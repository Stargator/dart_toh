// Copyright (c) 2017. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';

import 'hero_service.dart';
import 'heroes_component.dart';

@Component(
    selector: "my-heroes",
    directives: const [COMMON_DIRECTIVES, ROUTER_DIRECTIVES], // ignore: always_specify_types
    providers: const [HeroService, ROUTER_PROVIDERS] // ignore: always_specify_types
    template: '''
      <h1>{{title}}</h1>
      <a [routerLink]="['Heroes']">Heroes</a>
      <router-outlet></router-outlet>
    ''',
)

@RouteConfig(const [
  const Route(path: '/heroes', name: 'Heroes', component: HeroesComponent)
])

/// AppComponent class
/// Container of all components of the app
class AppComponent {
  /// Title of the app
  final String title = 'Tour of Heroes';
}
