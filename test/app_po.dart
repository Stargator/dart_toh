import 'dart:async';

import 'package:pageloader/objects.dart';

import 'utils.dart';

/// Page Object for Application
class AppPO {
  @ByTagName('h1')
  PageLoaderElement _h1;

  @ByCss('nav a')
  List<PageLoaderElement> _tabLinks;

  /// Title of page for component
  Future<String> get pageTitle => _h1.visibleText;

  /// Titles for tabs in component
  Future<List<String>> get tabTitles =>
      inIndexOrder(_tabLinks.map((el) => el.visibleText)).toList(); // ignore: always_specify_types
}
