import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'package:angular_tour_of_heroes/hero.dart';
import 'package:angular_tour_of_heroes/hero_service.dart';
import 'package:angular_tour_of_heroes/hero_search_component.dart';

@Component(
    selector: 'my-dashboard',
    templateUrl: 'dashboard_component.html',
    styleUrls: const ['dashboard_component.css'], // ignore: always_specify_types
    directives: const [CORE_DIRECTIVES, ROUTER_DIRECTIVES, HeroSearchComponent]
)

/// Component that handles the UI and logic of dashboard
class DashboardComponent implements OnInit {

  /// Heroes to display within the dashboard
  List<Hero> heroes;
  final HeroService _heroService;

  /// Constructor of Component
  DashboardComponent(this._heroService);

  @override
  Future<Null> ngOnInit() async {
    heroes = (await _heroService.getHeroes()).skip(1).take(4).toList();
  }
}