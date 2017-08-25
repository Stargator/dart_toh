import 'dart:async';

import 'package:pageloader/objects.dart';

import 'utils.dart';

/// Object to provide interactions with web UI
class HeroesPO {
  @FirstByCss('h2')
  PageLoaderElement _title;

  @ByTagName('li')
  List<PageLoaderElement> _heroes;

  @ByTagName('li')
  @WithClass('selected')
  @optional
  PageLoaderElement _selectedHero;

  @FirstByCss('div h2')
  @optional
  PageLoaderElement _miniDetailHeading;

  @ByCss('div button')
  List<PageLoaderElement> _buttons;

  @ByCss('li button')
  List<PageLoaderElement> _deleteHeroes;

  @ByTagName('input')
  PageLoaderElement _input;

  /// Title for component
  Future<String> get title => _title.visibleText;

  /// Retrieve list of heroes
  Iterable<Future<Map<String, dynamic>>> get heroes =>
      _heroes.map((el) async => _heroDataFromLi(await el.visibleText)); // ignore: always_specify_types

  /// Function to handle logic when clicking on a Hero
  Future<dynamic> clickHero(int index) => _heroes[index].click();

  /// Trigger delete mechanism
  Future deleteHero(int index) => _deleteHeroes[index].click(); // ignore: always_specify_types

  /// Retrieve the selected Hero
  Future<Map<String, dynamic>> get selectedHero async => _selectedHero == null
      ? null
      : _heroDataFromLi(await _selectedHero.visibleText);

  /// Convert Hero name to uppercase
  Future<String> get myHeroNameInUppercase async {
    if (_miniDetailHeading == null) {
      return null;
    }

    final text = await _miniDetailHeading.visibleText; // ignore: always_specify_types
    final matches = new RegExp((r'^(.*) is my hero\s*$')).firstMatch(text);
    return matches[1];
  }

  /// Mock process for adding a Hero
  Future<Null> addHero(String name) async {
    await _input.clear();
    await _input.type(name);
    return _buttons[0].click();
  }

  /// Navigation to detail view
  Future<Null> gotoDetail() async => _buttons[1].click();

  Map<String, dynamic> _heroDataFromLi(String liText) {
    final matches = new RegExp((r'^(\d+) (.*) x$')).firstMatch(liText); // ignore: always_specify_types
    return heroData(matches[1], matches[2]);
  }
}
