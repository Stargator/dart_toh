// Copyright (c) 2017. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';

@Component(
    selector: 'my-app',
    directives: const [COMMON_DIRECTIVES], // ignore: always_specify_types
    template: '''
    <h1>{{title}}</h1>
    <h2>{{hero.name}} details!</h2>
    <div><label>id: </label>{{hero.id}}</div>
    <div>
      <label>name: </label>
      <input [(ngModel)]="hero.name" placeholder="name">
    </div>
    ''')

/// AppComponent class
/// Container of all components of the app
class AppComponent {
  /// Title of the app
  String title = "Tour of Heroes";

  /// Temporary hero for the demo
  Hero hero = new Hero(1, "Windstorm");
}

/// Class that defines the attributes of heroes
class Hero {
  /// Unique Id
  final int id;
  /// Hero's given name
  String name;

  /// Only constructor with parameters
  Hero(this.id, this.name);
}