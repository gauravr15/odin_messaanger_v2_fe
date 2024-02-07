class RequestDTO {
  final String parameter;

  RequestDTO(this.parameter);

  Map<String, dynamic> toJson() {
    return {'parameter': parameter};
  }
}
