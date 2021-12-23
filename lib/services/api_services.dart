import 'package:ride_sharing/services/api_response.dart';
import 'package:ride_sharing/services/api_urls.dart';
import 'package:ride_sharing/services/base_api.dart';

class ApiService extends BaseApi {
  // Login ViewModel
  Future<ApiResponse> signupMethod(data) async {
    ApiResponse response;
    try {
      response = await signUp(data, '/users/register/');
    } catch (e) {
      response = ApiResponse(error: true, errorMessage: e.toString());
    }

    return response;
  }

  Future<ApiResponse> loginMethod(data) async {
    ApiResponse response;
    try {
      response = await signUp(data, "users/login");
      print('no error');
    } catch (e) {
      response = ApiResponse(error: true, errorMessage: e.toString());
    }

    return response;
  }

  Future<ApiResponse> getArticlesMethod({required String endpoint}) async {
    ApiResponse response;
    try {
      response = await getRequest(endpoint: endpoint);
      print('no error');
    } catch (e) {
      response = ApiResponse(error: true, errorMessage: e.toString());
    }
    return response;
  }

  Future<ApiResponse> sendFirebaseNotification(String token) async {
    ApiResponse response;
    try {
      response = await getRequest(endpoint: "/firebase/send", query: {
        "token": token,
      });
    } catch (e) {
      response = ApiResponse(error: true, errorMessage: e.toString());
    }
    return response;
  }
}
