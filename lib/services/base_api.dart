import 'dart:io';
import 'package:ride_sharing/services/prefs_services.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

import 'api_response.dart';
import 'http_exception.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class BaseApi {
  // final String _baseUrl = 'ride-sharing-server.herokuapp.com';
  final String _baseUrl = '192.168.1.5:3000';
  final String _authToken = Prefs().getToken();

  Future<ApiResponse> signUp(Map data, String endpoint) async {
    var responseBody = json.decode('{"data": "", "status": "NOK"}');

    try {
      final uri = Uri.http(_baseUrl, endpoint);
      print(uri);
      final response = await http.post(uri, body: data);
      print(response.statusCode);
      if (response.statusCode >= 200 && response.statusCode <= 207) {
        print('==');
        return ApiResponse(data: jsonDecode(response.body));
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        String error = 'Error occurred';
        data.keys.forEach((String key) {
          if (key.contains('error')) {
            error = data[key][0];
            print(error);
          }
        });
        return ApiResponse(error: true, errorMessage: error);
      }
    } on SocketException catch (error) {
      throw HttpException(message: 'No Internet Connection');
    } catch (e) {
      throw e;
    }
  }

  Future<void> googleLogIn(Map data, String endpoint) async {
    var responseBody = json.decode('{"data": "", "status": "NOK"}');

    try {
      final uri = Uri.https(_baseUrl, endpoint);
      print(uri);
      final response = await http.post(uri, body: data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        responseBody = jsonDecode(response.body);
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);

        String error = 'Error occurred';
        data.keys.forEach((String key) {
          if (key.contains('error')) {
            error = data[key][0];
            print(error);
          }
        });
        throw HttpException(message: error);
      }
    } on SocketException catch (error) {
      throw HttpException(message: 'No Internet Connection');
    } catch (e) {
      throw e;
    }
  }

  //GET
  Future<ApiResponse> getRequest(
      {required String endpoint, Map<String, Object>? query}) async {
    final uri = Uri.https(_baseUrl, endpoint, query);
    print(uri);
    return processResponse(await http.get(uri));
  }

  //GET Without Auth
  Future<ApiResponse> getWithoutAuthRequest(
      {required String endpoint, Map<String, String>? query}) async {
    final uri = Uri.http(_baseUrl, endpoint, query);
    print(uri);
    return processResponse(await http.get(
      uri,
    ));
  }

  //POST
  Future<ApiResponse> postRequest(
      String endpoint, Map<String, dynamic> data) async {
    print("posttttttttttttttttttt");
    final uri = Uri.http(_baseUrl, endpoint);
    print(uri);
    return processResponse(
      await http.post(uri, body: data),
    );
  }

  // PUT
  Future<ApiResponse> patchRequest(
      String endpoint, Map<String, dynamic> data) async {
    final uri = Uri.https(_baseUrl, endpoint);
    print(uri);
    return processResponse(await http.patch(uri,
        headers: {
          HttpHeaders.authorizationHeader: 'Token $_authToken',
        },
        body: data));
  }

  // DELETE
  Future<ApiResponse> deleteRequest(
      {required String endpoint, required String id}) async {
    final String endPointUrl = id == null ? endpoint : '$endpoint/' + '$id/';
    print(endPointUrl);
    final uri = Uri.https(_baseUrl, endPointUrl);
    print(uri);
    return processResponse(await http.delete(
      uri,
      headers: {
        HttpHeaders.authorizationHeader: 'Token $_authToken',
      },
    ));
  }

  Future<ApiResponse> processResponse(Response response) async {
    // if (_authToken.isEmpty || _authToken == null) {
    //   print('not logged in');
    //   return ApiResponse(error: true, errorMessage: 'User not logged in');
    // }
    try {
      if (response.statusCode >= 200 && response.statusCode <= 207) {
        print('==');
        return ApiResponse(data: jsonDecode(response.body));
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        String error = 'Error occurred';
        data.keys.forEach((String key) {
          if (key.contains('error')) {
            error = data[key][0];
            print(error);
          }
        });
        return ApiResponse(error: true, errorMessage: error);
      }
    } on SocketException catch (error) {
      print('socket');
      throw HttpException(message: 'No Internet Connection');
    } on PlatformException catch (error) {
      print('plt');
      throw HttpException(message: error.toString());
    } catch (e) {
      throw e;
    }
  }
}
