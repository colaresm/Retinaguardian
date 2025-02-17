class EmptyResponseModel {
  EmptyResponseModel();

  factory EmptyResponseModel.fromJson(Map<String, dynamic> json) {
    return EmptyResponseModel();
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}
