import 'dart:async';
import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:angular_tour_of_heroes/hero.dart';
import 'package:angular_tour_of_heroes/hero_search_service.dart';

@Component(
  selector: 'hero-search',
  templateUrl: 'hero_search_component.html',
  styleUrls: const <String>['hero_search_component.css'],
  directives: const <dynamic>[CORE_DIRECTIVES],
  providers: const <dynamic>[HeroSearchService],
  pipes: const <dynamic>[COMMON_PIPES],
)

/// Class for the Search template
class HeroSearchComponent implements OnInit {
  HeroSearchService _heroSearchService;
  Router _router;

  /// List of Heroes to display as results
  Stream<List<Hero>> heroes;

  final StreamController<String> _searchTerms =
      new StreamController<String>.broadcast();

  /// Constructor for HeroSearchComponent
  HeroSearchComponent(this._heroSearchService, this._router);

  /// Push a search term into the stream.
  void search(String term) => _searchTerms.add(term);

  @override
  Future<Null> ngOnInit() async {
    heroes = _searchTerms.stream
        .transform(debounce(const Duration(milliseconds: 300)))
        .distinct()
        .transform(switchMap((term) => term.isEmpty // ignore: always_specify_types
            ? new Stream<List<Hero>>.fromIterable([<Hero>[]])
            : _heroSearchService.search(term).asStream()))
        .handleError(print); // for demo purposes only
  }

  /// Navigational function to display Detail view
  void gotoDetail(Hero hero) {
    final link = [ // ignore: always_specify_types
      'HeroDetail',
      {'id': hero.id.toString()} // ignore: always_specify_types
    ];
    _router.navigate(link);
  }
}
