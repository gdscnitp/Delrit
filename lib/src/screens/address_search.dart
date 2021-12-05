import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ride_sharing/src/models/map_models.dart';

class AddressSearch extends SearchDelegate<Suggestion?> {
  final sessionToken;
  final Position position;
  late PlaceApiProvider apiClient;

  AddressSearch(this.sessionToken, this.position) {
    apiClient = PlaceApiProvider(sessionToken);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Suggestion>>(
      future: query == "" ? null : apiClient.fetchSuggestions(query, position),
      builder: (context, snapshot) => query == ""
          ? Container(
              padding: const EdgeInsets.all(10),
              child: const Text("Enter a location"),
            )
          : snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(snapshot.data![index].description),
                    onTap: () {
                      close(context, snapshot.data![index]);
                    },
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text("Loading"),
                ),
    );
  }
}
