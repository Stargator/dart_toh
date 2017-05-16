// Copyright (c) 2017. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';

@Component(
    selector: 'my-app',
    template: '''
    <h1>{{title}}</h1>
    <h2>{{hero.name}} details!</h2>
    <div><label>id: </label>{{hero.id}}</div>
    <div>
      <label>name: </label>
      <input [(ngModel)]="hero.name" placeholder="name">
    </div>
    ''')

class AppComponent {
  String title = "Tour of Heroes";
  Hero hero = new Hero(1, "Windstorm");
}

class Hero {
  final int id;
  String name;

  Hero(this.id, this.name);
}