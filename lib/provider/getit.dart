import 'package:http/http.dart';
import 'package:ride_sharing/services/api_services.dart';
import 'package:ride_sharing/services/navigation_service.dart';
import 'package:get_it/get_it.dart';
import 'package:ride_sharing/view/login_viewmodel.dart';

GetIt getIt = GetIt.instance;
void setupLocator() {
  getIt.registerLazySingleton(() => NavigationService());
  getIt.registerFactory(() => ApiService());
  getIt.registerFactory(() => LoginViewModel());
}
