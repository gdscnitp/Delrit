import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:ride_sharing/auth/secrets.dart';

class Suggestion {
  final String placeId;
  final String description;
  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return "Suggestion(desc : $description, id: $placeId";
  }
}

class PlaceApiProvider {
  final client = http.Client();
  final String sessionToken;
  PlaceApiProvider(this.sessionToken);

  final String apiKey = MAPAPIKEY;

  Future<List<Suggestion>> fetchSuggestions(
      String input, Position position) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&language=en&components=country:in&position=${position.latitude},${position.longitude}&radius=1000000&key=$apiKey&sessiontoken=$sessionToken');
    final response = await client.get(url);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      print(result);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
