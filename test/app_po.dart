import 'dart:async';

import 'package:pageloader/objects.dart';

/// Page Object for Application
class AppPO {
  @ByTagName('h1')
  PageLoaderElement _pageTitle;

  @FirstByCss('h2')
  PageLoaderElement _tabTitle;

  @ByTagName('li')
  List<PageLoaderElement> _heroes;

  @ByTagName('li')
  @WithClass('selected')
  @optional
  PageLoaderElement _selectedHero;

  @FirstByCss('div h2')
  @optional
  PageLoaderElement _heroDetailHeading;

  @FirstByCss('div div')
  @optional
  PageLoaderElement _heroDetailId;

  @ByTagName('input')
  @optional
  PageLoaderElement _input;

  /// Title of page for component
  Future<String> get pageTitle => _pageTitle.visibleText;

  /// Title of tab for component
  Future<String> get tabTitle => _tabTitle.visibleText;

  /// List of Heroes
  Iterable<Future<Map>> get heroes => // ignore: always_specify_types
      _heroes.map((el) async => _heroDataFromLi(await el.visibleText)); // ignore: always_specify_types

  /// Pretending to click on Hero object
  Future clickHero(int index) => _heroes[index].click(); // ignore: always_specify_types

  /// Hero selected by user
  Future<Map<String, dynamic>> get selectedHero async => _selectedHero == null
      ? null
      : _heroDataFromLi(await _selectedHero.visibleText);

  /// Details of selected Hero
  Future<Map<String, dynamic>> get heroFromDetails async {
    if (_heroDetailId == null) {
      return null;
    }

    final idAsString = (await _heroDetailId.visibleText).split(' ')[1]; // ignore: always_specify_types
    final text = await _heroDetailHeading.visibleText; // ignore: always_specify_types
    final matches = new RegExp((r'^(.*) details!$')).firstMatch(text); // ignore: always_specify_types
    return _heroData(idAsString, matches[1]);
  }

  /// Reset input value
  Future<dynamic> clear() => _input.clear();

  /// Set value for input
  Future<dynamic> type(String s) => _input.type(s);

  Map<String, dynamic> _heroData(String idAsString, String name) =>
      {'id': int.parse(idAsString, onError: (_) => -1), 'name': name}; // ignore: always_specify_types

  Map<String, dynamic> _heroDataFromLi(String liText) {
    final matches = new RegExp((r'^(\d+) (.*)$')).firstMatch(liText); // ignore: always_specify_types
    return _heroData(matches[1], matches[2]);
  }
}