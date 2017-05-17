// Copyright (c) 2017. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:angular2/angular2.dart';

@Component(
    selector: 'my-app',
    directives: const [COMMON_DIRECTIVES], // ignore: always_specify_types
    template: '''
    <h1>{{title}}</h1>
    <h2>My Heroes</h2>
    <ul class="heroes">
    <li *ngFor="let hero of heroes" (click)="selectedHero = hero"
    [class.selected]="hero == selectedHero">
      <span class="badge">{{hero.id}}</span> {{hero.name}}
    </li>
    </ul>

    <div *ngIf="selectedHero != null">
      <h2>{{selectedHero.name}} details!</h2>
      <div><label>id: </label>{{selectedHero.id}}</div>
      <div>
        <label>name: </label>
        <input [(ngModel)]="selectedHero.name" placeholder="name">
      </div>
    </div>
    ''',
  styles: const [ // ignore: always_specify_types
    '''
      .selected {
        background-color: #CFD8DC !important;
        color: white;
      }
      .heroes {
        margin: 0 0 2em 0;
        list-style-type: none;
        padding: 0;
        width: 15em;
      }
      .heroes li {
        cursor: pointer;
        position: relative;
        left: 0;
        background-color: #EEE;
        margin: .5em;
        padding: .3em 0em;
        height: 1.6em;
        border-radius: 4px;
      }
      .heroes li.selected:hover {
        color: white;
      }
      .heroes li:hover {
        color: #607D8B;
        background-color: #EEE;
        left: .1em;
      }
      .heroes .text {
        position: relative;
        top: -3px;
      }
      .heroes .badge {
        display: inline-block;
        font-size: small;
        color: white;
        padding: 0.8em 0.7em 0em 0.7em;
        background-color: #607D8B;
        line-height: 1em;
        position: relative;
        left: -1px;
        top: -4px;
        height: 1.8em;
        margin-right: .8em;
        border-radius: 4px 0px 0px 4px;
      }
    '''
  ]//, directives: const [COMMON_DIRECTIVES],
)

/// AppComponent class
/// Container of all components of the app
class AppComponent {
  /// Title of the app
  final String title = "Tour of Heroes";

  /// Hero selected by user
  Hero selectedHero;

  /// List of Heroes displayed in component
  final List<Hero> heroes = mockHeroes;

  /// Stores the hero selected by user
  void onSelect(Hero hero) => selectedHero = hero;
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

/// Hardcoded list of Heroes for the demo
final List<Hero> mockHeroes = <Hero>[
  new Hero(11, 'Mr. Nice'),
  new Hero(12, 'Narco'),
  new Hero(13, 'Bombasto'),
  new Hero(14, 'Celeritas'),
  new Hero(15, 'Magneta'),
  new Hero(16, 'RubberMan'),
  new Hero(17, 'Dynama'),
  new Hero(18, 'Dr IQ'),
  new Hero(19, 'Magma'),
  new Hero(20, 'Tornado')
];
