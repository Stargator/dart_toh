import 'dart:async';

import 'package:pageloader/objects.dart';

/// Page Object of Hero Details for testing purposes
class HeroDetailPO {
  @FirstByCss('div h2')
  @optional
  PageLoaderElement _heroDetailHeading;

  @FirstByCss('div div')
  @optional
  PageLoaderElement _heroDetailId;

  @ByTagName('input')
  @optional
  PageLoaderElement _input;

  /// Retrieve information about hero
  Future<Map<String, dynamic>> get heroFromDetails async {
    if (_heroDetailId == null) {
      return null;
    }

    final idAsString = (await _heroDetailId.visibleText).split(' ')[1]; // ignore: always_specify_types
    final text = await _heroDetailHeading.visibleText;
    final matches = new RegExp((r'^(.*) details!$')).firstMatch(text); // ignore: always_specify_types
    return _heroData(idAsString, matches[1]);
  }

  /// Clear input field
  Future<dynamic> clear() => _input.clear();

  /// Retrieve input value
  Future<dynamic> type(String s) => _input.type(s);

  Map<String, dynamic> _heroData(String idAsString, String name) =>
      {'id': int.parse(idAsString, onError: (_) => -1), 'name': name}; // ignore: always_specify_types
}
