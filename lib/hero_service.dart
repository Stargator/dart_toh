import 'dart:async';
import 'dart:convert';

import 'package:angular2/angular2.dart';
import 'package:http/http.dart';

import 'package:angular_tour_of_heroes/hero.dart';

/// Service to retrieve data related to heroes
@Injectable()
class HeroService {
  static const _heroesUrl = "api/heroes"; // URL to web API
  static final _headers = {'Content-Type': 'application/json'};
  final Client _http;

  HeroService(this._http);

  /// Method to retrieve fake hero list
  Future<List<Hero>> getHeroes() async {
    try {
      final response = await _http.get(_heroesUrl);

      final heroes = _extractData(response)
          .map((value) => new Hero.fromJson(value))
          .toList();

      return heroes;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<Hero> update(Hero hero) async {
    try {
      final url = '$_heroesUrl/$hero.id';

      final response = await _http.put(
          url, headers: _headers, body: JSON.encode(hero));

      return new Hero.fromJson(_extractData(response));

    } catch (ex) {
      throw _handleError(ex);
    }
  }

  /// See the "Take it slow" appendix
  Future<List<Hero>> getHeroesSlowly() => new Future<List<Hero>>.delayed(const Duration(seconds: 2), getHeroes);

  /// Retrieve hero data
  Future<Hero> getHero(int id) async {
    try {
      final response = await _http.get('$_heroesUrl/$id');

      final hero = new Hero.fromJson(_extractData(response));

      return hero;
    } catch (e) {
      throw _handleError(e);
    }
  }

  dynamic _extractData(Response resp) => JSON.decode(resp.body)['data'];

  Exception _handleError(dynamic e) {
    print(e); // for demo purposes only
    return new Exception("Server error; cause $e");
  }

  Future<Hero> create(String name) async {
    try {
      final response = await _http.post(_heroesUrl, headers: _headers, body: JSON.encode({'name': name}));

      final hero = new Hero.fromJson(_extractData(response));

      return hero;
    } catch (e) {
      throw _handleError(e);
    }
  }
}
