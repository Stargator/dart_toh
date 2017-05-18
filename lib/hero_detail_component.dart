import 'package:angular2/angular2.dart';
import 'hero.dart';

@Component(
  selector: 'my-hero-detail',
  directives: const [COMMON_DIRECTIVES],
  template: '''
      <div *ngIf="hero != null">
      <h2>{{hero.name}} details!</h2>
      <div><label>id: </label>{{hero.id}}</div>
      <div>
        <label>name: </label>
        <input [(ngModel)]="hero.name" placeholder="name">
      </div>
    </div>
  ''')
class HeroDetailComponent {
  @Input()
  Hero hero;
}
