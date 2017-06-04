@Tags(const <String>['aot'])
@TestOn('browser')
library heroes_test;

import 'package:angular2/angular2.dart';
import 'package:test/test.dart';

import 'dashboard.dart' as dashboard;
import 'hero_detail.dart' as hero_detail;
import 'heroes.dart' as heroes;

@AngularEntrypoint()
void main() {
  group('dashboard:', dashboard.main);
  group('heroes:', heroes.main);
  group('heroes_detail:', hero_detail.main);
}
