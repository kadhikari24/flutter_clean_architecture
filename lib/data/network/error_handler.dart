import 'package:complete_advanced_flutter/data/network/failure.dart';
import 'package:dio/dio.dart';

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unauthorised,
  notFound,
  internalServerError,
  connectionTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  unknown,
  noInternetConnection
}

class ResponseCode {
  // API status code
  static const int success = 200; // success with data
  static const int noContent = 201; // success with nno content
  static const int badRequest = 400; // failure, api rejected the request
  static const int forbidden = 403; // failure, api rejected the request
  static const int unauthorised = 401; //failure user is no authorized
  static const int notFound =
      404; // failure api url is not correct and not found
  static const int internalServerError = 500; // server error

  // local status code
  static const int unknown = -1;
  static const int connectionTimeout = -2;
  static const int cancel = -3;
  static const int sendTimeout = -4;
  static const int receiveTimeout = -5;
  static const int cacheError = -6;
  static const int noInternetConnection = -7;
}

class ResponseMessage {
  // API status code
  static const String success = 'success'; // success with data
  static const String noContent =
      'success with no content'; // success with nno content
  static const String badRequest =
      'Bad request, try again later'; // failure, api rejected the request
  static const String forbidden =
      'Forbidden request, try again later'; // failure, api rejected the request
  static const String unauthorised =
      'user is unauthorised, try again later'; //failure user is no authorized
  static const String notFound =
      'Url is not found, try again later'; // failure api url is not correct and not found
  static const String internalServerError =
      'Something want wrong, try again later'; // server error

  // local status code
  static const String unknown = 'something went wrong, try again later';
  static const String connectionTimeout = "time out error, try again later";
  static const String cancel = "request was cancelled, try again later";
  static const String sendTimeout = "time out error, try again later";
  static const String receiveTimeout = "time out error, try again later";
  static const String cacheError = "Cache error, try again later";
  static const String noInternetConnection =
      "Please check your internet connection";
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.success:
        return Failure(ResponseCode.success, ResponseMessage.success);
      case DataSource.noContent:
        return Failure(ResponseCode.noContent, ResponseMessage.noContent);
      case DataSource.badRequest:
        return Failure(ResponseCode.badRequest, ResponseMessage.badRequest);
      case DataSource.forbidden:
        return Failure(ResponseCode.forbidden, ResponseMessage.forbidden);
      case DataSource.unauthorised:
        return Failure(ResponseCode.unauthorised, ResponseMessage.unauthorised);
      case DataSource.notFound:
        return Failure(ResponseCode.notFound, ResponseMessage.notFound);
      case DataSource.internalServerError:
        return Failure(ResponseCode.internalServerError,
            ResponseMessage.internalServerError);
      case DataSource.connectionTimeout:
        return Failure(
            ResponseCode.connectionTimeout, ResponseMessage.connectionTimeout);

      case DataSource.cancel:
        return Failure(ResponseCode.cancel, ResponseMessage.cancel);

      case DataSource.receiveTimeout:
        return Failure(
            ResponseCode.receiveTimeout, ResponseMessage.receiveTimeout);
      case DataSource.sendTimeout:
        return Failure(ResponseCode.sendTimeout, ResponseMessage.sendTimeout);
      case DataSource.cacheError:
        return Failure(ResponseCode.cacheError, ResponseMessage.cacheError);
      case DataSource.noInternetConnection:
        return Failure(ResponseCode.noInternetConnection,
            ResponseMessage.noInternetConnection);

      default:
        return Failure(ResponseCode.unknown, ResponseMessage.unknown);
    }
  }
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      // dio error so it is error from response oof the API
      failure = _handleError(error);
    } else {
      failure = DataSource.unknown.getFailure();
    }
  }

  Failure _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectionTimeout:
        return DataSource.connectionTimeout.getFailure();
      case DioErrorType.sendTimeout:
        return DataSource.sendTimeout.getFailure();
      case DioErrorType.receiveTimeout:
        return DataSource.receiveTimeout.getFailure();
      case DioErrorType.badCertificate:
        switch (error.response?.statusCode) {
          case ResponseCode.badRequest:
            return DataSource.badRequest.getFailure();

          case ResponseCode.noContent:
            return DataSource.noContent.getFailure();

          case ResponseCode.forbidden:
            return DataSource.forbidden.getFailure();

          case ResponseCode.unauthorised:
            return DataSource.unauthorised.getFailure();

          case ResponseCode.internalServerError:
            return DataSource.internalServerError.getFailure();
        }
        return DataSource.unknown.getFailure();
      case DioErrorType.badResponse:
        return DataSource.notFound.getFailure();
      case DioErrorType.cancel:
        return DataSource.cancel.getFailure();
      case DioErrorType.connectionError:
        return DataSource.noInternetConnection.getFailure();
      case DioErrorType.unknown:
        return DataSource.unknown.getFailure();
    }
  }
}

class ApiInternalStatus{
  static const int success = 0;
  static const int failure = 1;
}
