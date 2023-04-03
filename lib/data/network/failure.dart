import 'package:complete_advanced_flutter/data/network/error_handler.dart';

class Failure {
  int code; // 200 or 400
  String message; // error or success
  Failure(this.code, this.message);

  Failure.def()
      : code = 22,
        message = "32";
}

class DefaultFailure extends Failure {
  DefaultFailure() : super(ResponseCode.unknown, ResponseMessage.unknown);
}
