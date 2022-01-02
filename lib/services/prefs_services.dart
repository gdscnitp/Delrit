import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  final String _userIDStorageKey = 'USER_ID';
  final String _authTokenStorageKey = 'AUTH_TOKEN';
  final String _currentRideKey = 'RIDE_ID';
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static String _authToken = "";
  static String _uid = "";
  static String _rideId = "";

  getToken() => _authToken;
  getUid() => _uid;

  Future<String> getAuthToken() async {
    final SharedPreferences prefs = await _prefs;
    _authToken = prefs.getString(_authTokenStorageKey) ?? '';

    return _authToken;
  }

  Future<String> getAuthUID() async {
    final SharedPreferences prefs = await _prefs;
    _uid = prefs.getString(_userIDStorageKey) ?? '';

    return _uid;
  }

  Future<String> getRideId() async {
    final SharedPreferences prefs = await _prefs;
    _rideId = prefs.getString(_currentRideKey) ?? '';

    return _rideId;
  }

  Future<void> setAuthToken(String token) async {
    final SharedPreferences prefs = await _prefs;
    print('called: $token');
    _authToken = token;
    prefs.setString(_authTokenStorageKey, token);
  }

  Future<void> setUID(String uID) async {
    final SharedPreferences prefs = await _prefs;
    _uid = uID;
    prefs.setString(_userIDStorageKey, uID);
  }

  Future<void> setRideId(String rideId) async {
    final SharedPreferences prefs = await _prefs;
    _rideId = rideId;
    prefs.setString(_currentRideKey, rideId);
  }

  Future<void> deleteTokens() async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove(_authTokenStorageKey);
    prefs.remove(_userIDStorageKey);
    _authToken = "";
  }
}
