// Copyright (c) 2017. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:angular2/core.dart';
import 'hero.dart';
import 'hero_service.dart';
import 'package:angular2/router.dart';

@Component(
  selector: 'my-heroes',
  templateUrl: 'heroes_component.html',
  directives: const [COMMON_DIRECTIVES],
  styleUrls: const ['heroes_component.css'],
  pipes: const [COMMON_PIPES],
)
class HeroesComponent implements OnInit {
  final HeroService _heroService;
  final Router _router;

  HeroesComponent(this._heroService, this._router);

  List<Hero> heroes;
  Hero selectedHero;

  Future<Null> getHeroes() async {
    heroes = await _heroService.getHeroes();
  }

  Future<Null> goToDetail() =>
      _router.navigate([
        'HeroDetail', {'id': selectedHero.id.toString()}
      ]);

  Future<Null> add(String name) async {
    name = name.trim();

    if (name.isEmpty) {
      return;
    }

    heroes.add(await _heroService.create(name));
    selectedHero = null;
  }

  void onSelect(Hero hero) {
    selectedHero = hero;
  }

  @override
  ngOnInit() {
    getHeroes();
  }
}

