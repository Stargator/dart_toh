import 'dart:async';
import 'dart:convert';

import 'package:angular2/angular2.dart';
import 'package:http/http.dart';

import 'package:angular_tour_of_heroes/hero.dart';

/// Service to retrieve data related to heroes
@Injectable()
class HeroService {
  static final Map<String, String> _headers = <String, String>{'Content-Type': 'application/json'};
  static const String _heroesUrl = 'api/heroes'; // URL to web API

  final Client _http;

  /// Constructor with Client parameter
  HeroService(this._http);

  /// Method to retrieve fake hero list
  Future<List<Hero>> getHeroes() async {
    try {
      final response = await _http.get(_heroesUrl); // ignore: always_specify_types

      final heroes = _extractData(response) // ignore: always_specify_types
          .map((value) => new Hero.fromJson(value))
          .toList();

      return heroes;
    } on Exception catch (e) {
      throw _handleError(e);
    }
  }

  dynamic _extractData(Response resp) => JSON.decode(resp.body)['data'];

  Exception _handleError(e) { // ignore: always_specify_types
    print(e); // for demo purposes only
    return new Exception('Server error; cause: $e');
  }

  /// Retrieve hero data
  Future<Hero> getHero(int id) async {
    try {
      final response = await _http.get('$_heroesUrl/$id'); // ignore: always_specify_types
      return new Hero.fromJson(_extractData(response));
    } on Exception catch (e) {
      throw _handleError(e);
    }
  }

  /// Create Hero based on name
  Future<Hero> create(String name) async {
    try {
      final response = await _http.post(_heroesUrl, // ignore: always_specify_types
          headers: _headers, body: JSON.encode({'name': name}));

      return new Hero.fromJson(_extractData(response));

    } on Exception catch (e) {
      throw _handleError(e);
    }
  }

  /// Update hero based on name
  Future<Hero> update(Hero hero) async {
    try {
      final url = '$_heroesUrl/${hero.id}'; // ignore: always_specify_types

      final response = // ignore: always_specify_types
          await _http.put(url, headers: _headers, body: JSON.encode(hero));

      return new Hero.fromJson(_extractData(response));

    } on Exception catch (e) {
      throw _handleError(e);
    }
  }

  /// Delete hero by id
  Future<Null> delete(int id) async {
    try {
      final url = '$_heroesUrl/$id'; // ignore: always_specify_types
      await _http.delete(url, headers: _headers);
    } on Exception catch (e) {
      throw _handleError(e);
    }
  }

  /// See the "Take it slow" appendix
  Future<List<Hero>> getHeroesSlowly() => new Future<List<Hero>>.delayed(const Duration(seconds: 2), getHeroes);

}
