import 'package:ride_sharing/services/api_services.dart';
import 'package:ride_sharing/services/navigation_service.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;
void setupLocator() {
  getIt.registerLazySingleton(() => NavigationService());
  getIt.registerFactory(() => ApiService());
}
