import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cat_breeds/repositories/util/custom_exceptions.dart';
import 'package:dio/dio.dart';

class ApiBaseHelper {
  final Dio dio;

  ApiBaseHelper({
    Dio? dio,
  }) : dio = dio ?? Dio();

  Future<dynamic> get(
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    dynamic responseJson;
    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: headers ??
              {
                HttpHeaders.contentTypeHeader: 'application/json',
                HttpHeaders.acceptHeader: 'application/json',
              },
        ),
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioException catch (e) {
      if (e.message?.contains('SocketException') ?? false) {
        throw FetchDataException(e.message);
      }
      if (e.type == DioExceptionType.cancel) {
        throw AbortException('Request was aborted');
      }
      final res = e.response;
      _returnResponse(
        Response(
          statusCode: res?.statusCode,
          statusMessage: res?.statusMessage,
          data: res?.data,
          requestOptions: RequestOptions(path: url),
        ),
      );
    } catch (e) {
      rethrow;
    }
    return responseJson;
  }

  Future<dynamic> post(
    String url, {
    Map<String, String>? headers,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    void Function(int count, int total)? onSendProgress,
    String? acceptHeader,
    CancelToken? cancelToken,
  }) async {
    dynamic responseJson;
    try {
      final response = await dio.post(
        url,
        options: Options(
          headers: headers ??
              {
                HttpHeaders.acceptHeader: acceptHeader ?? 'application/json',
              },
        ),
        data: body,
        queryParameters: queryParameters,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        throw AbortException('Request was aborted');
      }
      final res = e.response;
      _returnResponse(
        Response(
          statusCode: res?.statusCode,
          statusMessage: res?.statusMessage,
          data: res?.data,
          requestOptions: RequestOptions(path: url),
        ),
      );
    }
    return responseJson;
  }

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.data;
      case 400:
        throw BadRequestException(response.data.toString());
      case 403:
        throw PermissionException(response.data.toString());
      case 401:
        throw UnauthorizedException(response.data.toString());
      case 500:
      case 502:
      case 504:
      case 521:
      case 522:
        throw ServerException(response.data.toString());
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode} ${response.data} ${response.toString}');
    }
  }
}
