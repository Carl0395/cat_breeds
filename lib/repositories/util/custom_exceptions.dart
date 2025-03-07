class CustomException implements Exception {
  final dynamic message;
  final dynamic prefix;
  final String? code;

  CustomException([this.message, this.prefix, this.code]);

  @override
  String toString() {
    return "$prefix$message";
  }
}

class AbortException extends CustomException {
  AbortException([String? message]) : super(message, "AbortException: ");
}

class FetchDataException extends CustomException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorizedException extends CustomException {
  UnauthorizedException([message]) : super(message, "Unauthorized: ");
}

class InvalidInputException extends CustomException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}

class PermissionException extends CustomException {
  PermissionException([String? message, dynamic code])
      : super(message, "Permission Denied: ", '$code');
}

class UnknownException extends CustomException {
  UnknownException([String? message]) : super(message, "Unknown Error: ");
}

class ServerException extends CustomException {
  ServerException([String? message]) : super(message, "Server Error: ");
}

class ValidationException extends CustomException {
  ValidationException([String? message, dynamic code])
      : super(message, 'Validation Error: ', '$code');
}
