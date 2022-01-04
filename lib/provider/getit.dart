import 'package:ride_sharing/services/api_services.dart';
import 'package:ride_sharing/services/navigation_service.dart';
import 'package:get_it/get_it.dart';
import 'package:ride_sharing/view/available_drivers_viewmodel.dart';
import 'package:ride_sharing/view/chat_viewmodel.dart';
import 'package:ride_sharing/view/choose_location_viewmodel.dart';
import 'package:ride_sharing/view/complete_profile_viewmodel.dart';
import 'package:ride_sharing/view/driver_details_viewmodel.dart';
import 'package:ride_sharing/view/home_screen_view_model.dart';
import 'package:ride_sharing/view/login_viewmodel.dart';
import 'package:ride_sharing/view/post_ride_viewmodel.dart';
import 'package:ride_sharing/view/rider_details_viewmodel.dart';
import 'package:ride_sharing/view/search_rider_viewmodel.dart';
import 'package:ride_sharing/view/user_profile_viewmodel.dart';
import 'package:ride_sharing/view/available_riders_viewmodel.dart';

GetIt getIt = GetIt.instance;
void setupLocator() {
  getIt.registerLazySingleton(() => NavigationService());
  getIt.registerFactory(() => ApiService());
  getIt.registerFactory(() => LoginViewModel());
  getIt.registerFactory(() => SearchRiderViewModel());
  getIt.registerFactory(() => CompleteProfileViewModel());
  getIt.registerFactory(() => ChooseLocationViewModel());
  getIt.registerFactory(() => UserProfileViewModel());
  getIt.registerFactory(() => AvailableRidersViewModel());
  getIt.registerFactory(() => AvailableDriversViewModel());
  getIt.registerFactory(() => ChatScreenModel());
  getIt.registerFactory(() => PostRideViewModel());
  getIt.registerFactory(() => RiderDetailsViewModel());
  getIt.registerFactory(() => DriverDetailsViewModel());
  getIt.registerFactory(() => HomeScreenViewModel());
}
