import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';

import 'package:angular_tour_of_heroes/hero.dart';
import 'package:angular_tour_of_heroes/hero_service.dart';

@Component(
    selector: 'hero-detail',
    directives: const <dynamic>[COMMON_DIRECTIVES],
    templateUrl: 'hero_detail_component.html',
    styleUrls: const <String>['hero_detail_component.css']
)

/// Component for information on Heroes
class HeroDetailComponent implements OnInit {

  /// Hero whose details are displayed
  Hero hero;
  final HeroService _heroService;
  final RouteParams _routeParams;
  final Location _location;

  /// Constructor for Component
  HeroDetailComponent(this._heroService, this._routeParams, this._location);

  @override
  Future<Null> ngOnInit() async {
    final _id = _routeParams.get('id'); // ignore: always_specify_types
    final id = int.parse(_id ?? '', onError: (_) => -1);

    if (id != null && id >= 0) {
      hero = await (_heroService.getHero(id));
    }
  }

  /// Navigational function to go to previous view
  void goBack() => _location.back();

  /// Send Hero details to update remote record
  Future<Null> save() async {
    await (_heroService.update(hero));
    goBack();
  }
}
