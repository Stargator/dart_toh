// Copyright (c) 2017. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:angular2/angular2.dart';
import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:angular_tour_of_heroes/hero.dart';
import 'package:angular_tour_of_heroes/hero_service.dart';

@Component(
  selector: 'my-heroes',
  templateUrl: 'heroes_component.html',
  directives: const [CORE_DIRECTIVES], // ignore: always_specify_types
  providers: const [HeroService],
  styleUrls: const ['heroes_component.css'], // ignore: always_specify_types
  pipes: const [COMMON_PIPES],
)

/// HeroesComponent class
/// Handles the logic and View of the Heroes template
class HeroesComponent implements OnInit {
  final Router _router;
  final HeroService _heroService;

  /// All the heroes to display
  List<Hero> heroes;

  /// User chosen hero
  Hero selectedHero;

  /// Constructor for the component template
  HeroesComponent(this._heroService, this._router);

  /// Retrieve heroes from service
  Future<Null> getHeroes() async {
    heroes = await _heroService.getHeroes();
  }

  /// Navigational function to transition to Detail view
  Future<Null> gotoDetail() => _router.navigate(<dynamic>[
    'HeroDetail',
    <String, dynamic>{'id': selectedHero.id.toString()}
  ]);

  Future<Null> add(String name) async {
    name = name.trim();

    if (name.isEmpty) {
      return;
    }

    heroes.add(await _heroService.create(name));
    selectedHero = null;
  }

  Future<Null> delete(Hero hero) async {
    await _heroService.delete(hero.id);
    heroes.remove(hero);
    if (selectedHero == hero) selectedHero = null;
  }

  /// Function to handle logic when hero is selected
  void onSelect(Hero hero) => selectedHero = hero;

  @override
  void ngOnInit() {
    getHeroes();
  }
}
