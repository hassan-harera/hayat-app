class ApiError {
  final int status;
  final DateTime timestamp;
  final String message;
  final String debugMessage;
  final String displayMessage;
  final String code;

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
        status: json['status'] as int,
        timestamp: DateTime.parse(json['timestamp'] as String),
        message: json['message'] as String,
        debugMessage: json['debugMessage'] as String,
        displayMessage: json['displayMessage'] as String,
        code: json['code'] as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'timestamp': timestamp.toIso8601String(),
      'message': message,
      'debugMessage': debugMessage,
      'displayMessage': displayMessage,
      'code': code
    };
  }
}
