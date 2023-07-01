class ApiError {
  final String status;
  final String timestamp;
  final String? message;
  final String? debugMessage;
  final String? displayMessage;
  final String? code;

  ApiError({
    required this.status,
    required this.timestamp,
    required this.message,
    required this.debugMessage,
    required this.displayMessage,
    required this.code,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
        status: json['status'] as String,
        timestamp: json['timestamp'] as String,
        message: json['message'],
        debugMessage: json['debugMessage'],
        displayMessage: json['displayMessage'],
        code: json['code']);
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'timestamp': timestamp,
      'message': message,
      'debugMessage': debugMessage,
      'displayMessage': displayMessage,
      'code': code
    };
  }
}
