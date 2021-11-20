import 'package:ride_sharing/provider/base_model.dart';
import 'package:ride_sharing/services/api_services.dart';

class LoginViewModel extends BaseModel {
  final ApiService _apiService = ApiService();

  void signInWithNumber() {}

  void signInWithGoogle() {}

  void signInWithFacebook() {}
}
