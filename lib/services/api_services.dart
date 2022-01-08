import 'package:ride_sharing/services/api_response.dart';
import 'package:ride_sharing/services/api_urls.dart';
import 'package:ride_sharing/services/base_api.dart';

class ApiService extends BaseApi {
  // Login ViewModel

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

  Future<ApiResponse> sendRequestNotificationToDriver(
      Map<String, dynamic> body) async {
    ApiResponse response;
    try {
      response = await postRequest("/firebase/send-req-to-driver", body);
    } catch (e) {
      response = ApiResponse(error: true, errorMessage: e.toString());
    }
    return response;
  }

  Future<ApiResponse> sendRequestNotificationToRider(
      Map<String, dynamic> body) async {
    ApiResponse response;
    try {
      response = await postRequest("/firebase/send-req-to-rider", body);
    } catch (e) {
      response = ApiResponse(error: true, errorMessage: e.toString());
    }
    return response;
  }

  Future<ApiResponse> sendChatNotification(Map<String, dynamic> body) async {
    ApiResponse response;
    try {
      response = await postRequest("/firebase/send-chat-notification", body);
    } catch (e) {
      response = ApiResponse(error: true, errorMessage: e.toString());
    }
    return response;
  }
}
