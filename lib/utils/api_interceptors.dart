import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:odin_messenger_v2/models/requestDTO.dart';
import 'package:odin_messenger_v2/models/responseDTO.dart';
import 'package:odin_messenger_v2/utils/encriptor.dart';

class CustomHttpClient extends http.BaseClient {
  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    // Apply your request filtering logic here before sending the request
    // For example, you can modify headers, add authentication tokens, etc.

    // Convert the request body to JSON
    if (request is http.Request && request.method != 'GET') {
      final Map<String, dynamic> requestBody = json.decode(request.body);

      // Assuming request parameter is a top-level key in requestBody
      final String encryptedBody = AESUtils()
          .encrypt(json.encode(requestBody['request']), 'abcdefgh987654321');

      // Create a RequestDTO object and set the encrypted body
      final RequestDTO requestDto = RequestDTO(encryptedBody);

      // Replace the existing non-encrypted request body with the JSON representation of RequestDTO
      request.body = json.encode(requestDto.toJson());
    }

    // Log the request details
    print('Request: ${request.method} ${request.url}');
    print('Headers: ${request.headers}');
    if (request is http.Request) {
      // If the request is of type http.Request, log the request body
      print('Body: ${request.body}');
    }

    // Do not use request.finalize() here

    // Convert the request to a StreamedResponse
    final http.StreamedResponse streamedResponse = await _inner.send(request);

    // Log the response details
    print('Response: ${streamedResponse.statusCode}');
    print('Headers: ${streamedResponse.headers}');

    // Decode the response body
    final List<int> bodyBytes = await streamedResponse.stream.toBytes();
    final String responseBody = utf8.decode(bodyBytes); // Add this line
    print('Body: $responseBody');

    // Decode the response body
    final Map<String, dynamic> decodedResponse = json.decode(responseBody);

    // Decrypt the 'data' parameter if it exists
    if (decodedResponse.containsKey('data')) {
      final String encryptedData = decodedResponse['data'];
      final String decryptedData =
          AESUtils().decrypt(encryptedData, 'abcdefgh987654321');
      decodedResponse['data'] = decryptedData;
    }

    // Convert the decoded response back to JSON
    final String updatedResponseBody = json.encode(decodedResponse);

    // Print the updated response body
    print('Updated Body: $updatedResponseBody');

    // Map the JSON response to the ResponseDTO object
    final ResponseDTO responseDto =
        ResponseDTO.fromJson(json.decode(updatedResponseBody));

// Use the responseDto object as needed

// Convert the decoded response back to JSON
    final String jsonResponse = json.encode(responseDto);

// Print the updated response body
    print('Updated Body: $jsonResponse');

// Return the modified response with the updated body
    return http.StreamedResponse(
        http.ByteStream.fromBytes(utf8.encode(jsonResponse)),
        streamedResponse.statusCode,
        headers: {'content-type': 'application/json'});
  }
}
