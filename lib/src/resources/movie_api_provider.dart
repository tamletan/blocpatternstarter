import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern_starter/src/resources/utils.dart';
import 'package:http/http.dart' show Client;

import '../models/item_model.dart';
import '../models/trailer_model.dart';

class MovieApiProvider {
  Client client = Client();

  Future<ItemModel> fetchMovieList() async {
    final response = await client.get("$BASEURL/$TOKEN_POPULAR=$APIKEY");
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<TrailerModel> fetchTrailer(int movieId) async {
    final response =
    await client.get("$BASEURL/$movieId/$TOKEN_TRAILER=$APIKEY");

    if (response.statusCode == 200) {
      return TrailerModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load trailers');
    }
  }
}