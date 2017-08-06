// Copyright (c) 2017. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';

import 'package:angular_tour_of_heroes/dashboard_component.dart';
import 'package:angular_tour_of_heroes/hero_detail_component.dart';
import 'package:angular_tour_of_heroes/hero_service.dart';
import 'package:angular_tour_of_heroes/heroes_component.dart';

@Component(
  selector: "my-heroes",
  directives: const [ROUTER_DIRECTIVES], // ignore: always_specify_types
  providers: const [HeroService, ROUTER_PROVIDERS], // ignore: always_specify_types
  styleUrls: const ['app_component.css'], // ignore: always_specify_types
  template: '''
    <h1>{{title}}</h1>
    <nav>
      <a [routerLink]="['Dashboard']">Dashboard</a>
      <a [routerLink]="['Heroes']">Heroes</a>
    </nav>
    <router-outlet></router-outlet>
    '''
)

@RouteConfig(const <Route>[
  const Route(
      path: '/dashboard',
      name: 'Dashboard',
      component: DashboardComponent,
      useAsDefault: true),
  const Route(
      path: '/detail/:id', name: 'HeroDetail', component: HeroDetailComponent),
  const Route(path: '/heroes', name: 'Heroes', component: HeroesComponent)
])

/// AppComponent class
/// Container of all components of the app
class AppComponent {
  /// Title of the app
  final String title = 'Tour of Heroes';
}
