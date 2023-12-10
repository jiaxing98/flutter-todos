import 'package:bloc_tutorial_todo/core/network/failure.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

mixin HandleExceptionMixin {
  Failure handleRemoteException(Exception ex) {
    if (ex.runtimeType is DioException) {
      var dioEx = ex as DioException;
      switch (dioEx.type) {
        case DioExceptionType.badResponse:
          return _validateBadResponse(dioEx.response);
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.connectionTimeout:
          return ConnectionFailure(
              message: dioEx.message ?? 'Connection Timeout');
        default:
          return const UnknownFailure(message: 'Unknown Failure');
      }
    } else {
      return const UnknownFailure(message: 'Unknown Failure');
    }
  }

  Failure handleLocalException(Exception ex) {
    if (ex.runtimeType is HiveError) {
      var err = ex as HiveError;
      return DatabaseFailure(message: err.message);
    } else {
      return const UnknownFailure(message: 'Unknown Failure');
    }
  }

  ServerFailure _validateBadResponse(Response? response) {
    var errorMessage = 'Unknown Server Failure';

    if (response == null) {
      return ServerFailure(message: errorMessage);
    }

    switch (response.statusCode) {
      case 400:
        errorMessage = 'Bad Request';
      case 401:
        errorMessage = 'Unauthorized';
      case 403:
        errorMessage = 'Forbidden';
      case 404:
        errorMessage = 'Not Found';
      case 405:
        errorMessage = 'Method Not Allowed';
      case 500:
        errorMessage = 'Internal Server Error';
      default:
        break;
    }

    return ServerFailure(message: response.statusMessage ?? errorMessage);
  }
}
