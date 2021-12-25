import 'package:http/http.dart';
import 'package:ride_sharing/services/api_services.dart';
import 'package:ride_sharing/services/navigation_service.dart';
import 'package:get_it/get_it.dart';
import 'package:ride_sharing/view/add_ride_viewmodel.dart';
import 'package:ride_sharing/view/choose_location_viewmodel.dart';
import 'package:ride_sharing/view/complete_profile_viewmodel.dart';
import 'package:ride_sharing/view/login_viewmodel.dart';
import 'package:ride_sharing/view/search_rider_viewmodel.dart';

GetIt getIt = GetIt.instance;
void setupLocator() {
  getIt.registerLazySingleton(() => NavigationService());
  getIt.registerFactory(() => ApiService());
  getIt.registerFactory(() => LoginViewModel());
  getIt.registerFactory(() => AddRideViewModel());
  getIt.registerFactory(() => SearchRiderViewModel());
  getIt.registerFactory(() => CompleteProfileViewModel());
  getIt.registerFactory(() => ChooseLocationViewModel());
}
