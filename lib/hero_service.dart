import 'dart:async';

import 'package:angular2/angular2.dart';

import 'package:angular_tour_of_heroes/hero.dart';
import 'package:angular_tour_of_heroes/mock_heroes.dart';

/// Service to retrieve data related to heroes
@Injectable()
class HeroService {
  /// Method to retrieve fake hero list
  Future<List<Hero>> getHeroes() async => mockHeroes;

  /// See the "Take it slow" appendix
  Future<List<Hero>> getHeroesSlowly() => new Future<List<Hero>>.delayed(const Duration(seconds: 2), getHeroes);

  /// Retrieve hero data
  Future<Hero> getHero(int id) async =>
      (await getHeroes()).firstWhere((hero) => hero.id == id); // ignore: always_specify_types
}
