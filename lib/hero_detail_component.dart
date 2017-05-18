import 'package:angular2/angular2.dart';

import 'package:angular_tour_of_heroes/hero.dart';

@Component(
    selector: 'hero-detail',
    directives: const <dynamic>[COMMON_DIRECTIVES],
    template: '''
    <div *ngIf="hero != null">
      <h2>{{hero.name}} details!</h2>
      <div><label>id: </label>{{hero.id}}</div>
      <div>
        <label>name: </label>
        <input [(ngModel)]="hero.name" placeholder="name"/>
      </div>
    </div>
  '''
)

/// Component for information on Heroes
class HeroDetailComponent {

  /// Hero changed by user input
  @Input()
  Hero hero;
}
