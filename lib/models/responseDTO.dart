class ResponseDTO<T> {
  String status;
  int statusCode;
  T data;
  String message;

  ResponseDTO(this.status, this.statusCode, this.data, this.message);

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'statusCode': statusCode,
      'data': data,
      'message': message,
    };
  }

  factory ResponseDTO.fromJson(Map<String, dynamic> json) {
    return ResponseDTO(
      json['status'] as String,
      json['statusCode'] as int,
      json['data'] as T,
      json['message'] as String,
    );
  }
}
