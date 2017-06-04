import 'dart:async';

import 'package:pageloader/objects.dart';

import 'utils.dart';

/// Object to provide interactions with web UI
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

  @ByTagName('button')
  @optional
  PageLoaderElement _button;

  /// Retrieve information about hero
  Future<Map<String, dynamic>> get heroFromDetails async {
    if (_heroDetailId == null) {
      return null;
    }

    final idAsString = (await _heroDetailId.visibleText).split(' ')[1]; // ignore: always_specify_types
    final text = await _heroDetailHeading.visibleText;
    final matches = new RegExp((r'^(.*) details!$')).firstMatch(text); // ignore: always_specify_types
    return heroData(idAsString, matches[1]);
  }

  /// Clear input field
  Future<dynamic> clear() => _input.clear();

  /// Retrieve input value
  Future<dynamic> type(String s) => _input.type(s);

  /// Navigational function to go to the previous view
  Future<dynamic> back() => _button.click();
}
