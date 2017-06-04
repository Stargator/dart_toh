// Copyright (c) 2017. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';

import 'dashboard_component.dart';
import 'hero_detail_component.dart';
import 'hero_service.dart';
import 'heroes_component.dart';

@Component(
    selector: "my-heroes",
    directives: const [COMMON_DIRECTIVES, ROUTER_DIRECTIVES], // ignore: always_specify_types
    providers: const [HeroService, ROUTER_PROVIDERS], // ignore: always_specify_types
    template: '''
    <h1>{{title}}</h1>
    <nav>
      <a [routerLink]="['Dashboard']">Dashboard</a>
      <a [routerLink]="['Heroes']">Heroes</a>
    </nav>
    <router-outlet></router-outlet>
    ''',
)

@RouteConfig(const <Route>[
  const Route(path: '/heroes', name: 'Heroes', component: HeroesComponent),
  const Route(path: '/dashboard', name: 'Dashboard', component: DashboardComponent, useAsDefault: true),
  const Route(path: '/detail/:id', name: 'HeroDetail', component: HeroDetailComponent)
])

/// AppComponent class
/// Container of all components of the app
class AppComponent {
  /// Title of the app
  final String title = 'Tour of Heroes';
}
