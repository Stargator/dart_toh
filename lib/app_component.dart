
import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';

import 'hero_service.dart';
import 'heroes_component.dart';

@Component(
  selector: "my-heroes",
  template: '''
    <h1>{{title}}</h1>
    <a [routerLink]="['Heroes']">Heroes</a>
    <router-outlet></router-outlet>
    ''',
    directives: const [ROUTER_DIRECTIVES],
    providers: const [HeroService, ROUTER_PROVIDERS]
)

@RouteConfig(const [
  const Route(path: '/heroes', name: 'Heroes', component: HeroesComponent)
])

class AppComponent {
  final String title = "Tour of Heroes";
}