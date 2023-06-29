class ApiError {
  String? status;
  String? timestamp;
  String? message;
  Null? debugMessage;
  String? displayMessage;
  String? code;
  Null? subErrors;

  ApiError(
      {this.status,
      this.timestamp,
      this.message,
      this.debugMessage,
      this.displayMessage,
      this.code,
      this.subErrors});

  ApiError.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    timestamp = json['timestamp'];
    message = json['message'];
    debugMessage = json['debugMessage'];
    displayMessage = json['displayMessage'];
    code = json['code'];
    subErrors = json['subErrors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['timestamp'] = this.timestamp;
    data['message'] = this.message;
    data['debugMessage'] = this.debugMessage;
    data['displayMessage'] = this.displayMessage;
    data['code'] = this.code;
    data['subErrors'] = this.subErrors;
    return data;
  }
}
