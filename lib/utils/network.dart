import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:katarasa/utils/base_response.dart';
import 'package:katarasa/utils/cache_storage.dart';
import 'package:katarasa/utils/constant.dart';
import 'package:katarasa/utils/exception.dart';

late dio.Dio network;

initTokenHeader(String token) async {
  // network.options.headers['X-Token'] = token;
  network.options.headers['Authorization'] = 'Bearer $token';
}

Future<void> initNetwork() async {
  //env API
  String baseUrl = EnvValue.SECRET_API;

  dio.BaseOptions options = dio.BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      receiveTimeout: const Duration(seconds: 5),
      connectTimeout: const Duration(seconds: 5),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      });

  network = dio.Dio(options);

  network.interceptors.add(dio.LogInterceptor(
      responseBody: true, requestHeader: false, responseHeader: true));

  network.interceptors
      .add(dio.InterceptorsWrapper(onResponse: (response, handler) {
    final statusCode = response.statusCode;

    List<int> successCode = [RESPONSE_OK, RESPONSE_OK_NO_CONTENT];

    if (!successCode.contains(statusCode)) {
      _returnResponse(response, handler);
    }
    return handler.next(response);
  }, onError: (dio.DioException e, handler) {
    return handler.next(e);
  }));

  if (TOKEN != '') {
    // network.options.headers['X-TOKEN'] = TOKEN;
    network.options.headers['Authorization'] = 'Bearer $TOKEN';
  }
}

//CALL API
Future<ObjResponse> callNetwork(String url,
    {String mode = GET_METHOD,
    Map<String, dynamic> body = const {},
    bool hasFile = false}) async {
  dio.Response response;
  Map<String, dynamic> emptyObject = {};
  dio.Headers? headers;
  ObjResponse res = ObjResponse(
      false,
      emptyObject,
      headers,
      BaseResponse(
          status: Status(code: 0, message: ''), data: {}, message: ''));

  try {
    if (mode == GET_METHOD) {
      response = await network.get(url, queryParameters: body);
    } else {
      if (mode == DELETE_METHOD) {
        response = await network.delete(url, data: body);
      } else if (mode == PUT_METHOD) {
        response = await network.put(url, data: body);
      } else if (mode == PATCH_METHOD) {
        if (hasFile) {
          body['_method'] = 'PATCH';
          dio.FormData formData = dio.FormData.fromMap(body);
          response = await network.post(url, data: formData);
        } else {
          response = await network.patch(url, data: body);
        }
      } else {
        if (hasFile) {
          dio.FormData formData = dio.FormData.fromMap(body);
          response = await network.post(url, data: formData);
        } else {
          response = await network.post(url, data: body);
        }
      }
    }
    //RESPONSE 200 OK
    if (response.statusCode == RESPONSE_OK) {
      res.errresponse.status.code = RESPONSE_OK;
      res.success = true;
      res.headers = response.headers;
      res.response = response.data;
      return res;
    }

    //RESPONSE 204 OK BUT NO CONTENT
    if (response.statusCode == RESPONSE_OK_NO_CONTENT) {
      res.errresponse.status.code = RESPONSE_OK_NO_CONTENT;
      res.success = true;
      res.headers = response.headers;
      res.response = response.data;
      return res;
    }

    //RESPONSE 401 Unautohrized
    if (response.statusCode == RESPONSE_UNAUTHORIZED) {
      res.errresponse.status.code = RESPONSE_UNAUTHORIZED;
      res.success = true;
      res.headers = response.headers;
      res.response = response.data;
      return res;
    }

    //RESPONSE 403 Forbidden Access
    if (response.statusCode == RESPONSE_FORBIDDEN_ACCESS) {
      res.errresponse.status.code = RESPONSE_FORBIDDEN_ACCESS;
      res.success = true;
      res.headers = response.headers;
      res.response = response.data;
      return res;
    }

    //RESPONSE 404 Not Found
    if (response.statusCode == RESPONSE_NOT_FOUND) {
      res.errresponse.status.code = RESPONSE_NOT_FOUND;
      res.success = true;
      res.headers = response.headers;
      res.response = response.data;
      return res;
    }

    if (response.data != null && response.data is String) {
      res.errresponse.message = 'No data';
    } else if (response.data != null &&
        response.data.containsKey('status') &&
        response.data['status'] == false) {
      String msg = 'Error: ${response.statusCode}';
      if (response.data.containsKey('message')) {
        msg = response.data['message'];
      }
      if (response.data.containsKey('data')) {
        msg += ': ' + response.data['data'];
      }
      res.errresponse.message = msg;
    } else {
      // success response goes here
      res.success = true;
      res.headers = response.headers;
      res.response = response.data;
    }
  } on dio.DioException catch (e) {
    String messageErr = e.toString();

    if (e.type == dio.DioExceptionType.connectionTimeout ||
        e.type == dio.DioExceptionType.receiveTimeout) {
      throw TimeoutException();
    }

    // if (e.response!.statusCode == RESPONSE_UNAUTHORIZED) {
    //   messageErr = "Unauthorized";
    // }

    // cannot get regular err message
    if (messageErr == "") {
      messageErr = "Server Problem";
      if (e.response != null) {
        messageErr = "$messageErr [${e.response!.statusCode}]";
      }
      messageErr = "$messageErr : ${e.message}";
    }

    if (e.error is HttpException) {
      messageErr = "HTTP Issue [ ${e.type} ]";
    }

    // special case for validation err
    if (e.response != null && e.response!.statusCode == RESPONSE_VALIDATION) {
      throw InvalidInputException(e.response!.data['message']);
    }

    if (e.response != null && e.response!.statusCode == RESPONSE_SERVER_ERROR) {
      throw InternalServerException();
    }

    // if happen general error
    if (e.type == dio.DioExceptionType.unknown) {
      throw ConnectionProblemException();
    }

    // throw BadRequestException(messageErr, e.response);
    res.errresponse.message = e.response!.data['message'];

    // has response from server, not used
    // res.errresponse = new obj.BaseResponse(
    //   code: e.response.statusCode,
    //   message: messageErr,
    //   response: e.response,
    // );
  } catch (e) {
    // unhandled exception
    res.errresponse.status.code = RESPONSE_BAD_REQUEST;
    if (e is SocketException) {
      res.errresponse.message = "Server unreachable";
    } else {
      res.errresponse.message = e.toString();
    }
  }
  return res;
}

dynamic _returnResponse(dio.Response response, dynamic error) {
  switch (response.statusCode) {
    case RESPONSE_OK:
    case RESPONSE_OK_NO_CONTENT:
      var responseJson = json.decode(response.toString());
      return responseJson;
    case RESPONSE_BAD_REQUEST:
      return 'Bad Request';
    case RESPONSE_UNAUTHORIZED:
      return error["message"];
    case RESPONSE_NOT_FOUND:
      return error["message"];
    case RESPONSE_FORBIDDEN_ACCESS:
      return error["message"];
    case RESPONSE_VALIDATION:
      return error["message"];
    case RESPONSE_SERVER_ERROR:
      return 'Internal server error';
    default:
      return 'Oops something went wrong';
  }
}
