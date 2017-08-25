import 'dart:async';

import 'package:pageloader/objects.dart';

import 'utils.dart';

/// Object to provide interactions with web UI
class DashboardPO {
  @FirstByCss('h3')
  PageLoaderElement _title;

  @ByTagName('a')
  List<PageLoaderElement> _heroes;

  /// Search Element
  @ByTagName('input')
  PageLoaderElement search;

  @ByCss('div[id="search-component"] div div')
  List<PageLoaderElement> _heroesFound;

  /// Hero Service element
  @ByCss('div[id="search-component"]')
  PageLoaderElement heroSearchDiv;

  /// The title within the component
  Future<String> get title => _title.visibleText;

  /// List of names for heroes
  Future<List<String>> get heroNames =>
      inIndexOrder(_heroes.map((el) => el.visibleText)).toList(); // ignore: always_specify_types

  /// Function to handle the logic for clicking on a Hero
  Future<dynamic> clickHero(int index) => _heroes[index].click();

  /// Mock service to get
  Future<List<String>> get heroesFound =>
      inIndexOrder(_heroesFound.map((el) => el.visibleText)).toList(); // ignore: always_specify_types
}
