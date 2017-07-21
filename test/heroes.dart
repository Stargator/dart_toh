@Tags(const <String>['aot'])
@TestOn('browser')

import 'package:angular2/angular2.dart';
import 'package:angular2/router.dart';
import 'package:angular_test/angular_test.dart';
import 'package:angular_tour_of_heroes/in_memory_data_service.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:angular_tour_of_heroes/heroes_component.dart';
import 'package:angular_tour_of_heroes/hero_service.dart';

import 'heroes_po.dart';

/// Object that provides capability to test HeroesComponent
NgTestFixture<HeroesComponent> fixture;

/// Object to provide interactions with web UI
HeroesPO po;

/// Testable version of Router
class MockRouter extends Mock implements Router {}

/// Instance of Testable Router
final MockRouter mockRouter = new MockRouter();

@AngularEntrypoint()
void main() {
  final testBed = new NgTestBed<HeroesComponent>().addProviders([ // ignore: always_specify_types
    provide(Client, useClass: InMemoryDataService),
    provide(Router, useValue: mockRouter),
    HeroService,
  ]);

  setUp(() async {
    InMemoryDataService.resetDb();
    fixture = await testBed.create();
    po = await fixture.resolvePageObject(HeroesPO);
  });

  tearDown(disposeAnyRunningTest);

  group('Basics:', basicTests);
  group('Selected hero:', selectedHeroTests);
}

/// Group of simple tests
void basicTests() {
  test('title', () async {
    expect(await po.title, 'My Heroes');
  });

  test('hero count', () async {
    expect(po.heroes.length, 10);
  });

  test('no selected hero', () async {
    expect(await po.selectedHero, null);
  });
}

/// Group of tests related to selecting a hero
void selectedHeroTests() {
  const targetHero = const {'id': 15, 'name': 'Magneta'}; // ignore: always_specify_types

  setUp(() async {
    await po.clickHero(4);
    po = await fixture.resolvePageObject(HeroesPO);
  });

  test('is selected', () async {
    expect(await po.selectedHero, targetHero);
  });

  test('show mini-detail', () async {
    expect(
        await po.myHeroNameInUppercase, equals(targetHero['name'].toString().toUpperCase()));
  });

  test('go to detail', () async {
    await po.gotoDetail();
    final c = verify(mockRouter.navigate(captureAny)); // ignore: always_specify_types
    final linkParams = [
      'HeroDetail',
      {'id': '${targetHero['id']}'} // ignore: always_specify_types
    ];
    expect(c.captured.single, linkParams);
  });

  test('select another hero', () async {
    await po.clickHero(0);
    po = await fixture.resolvePageObject(HeroesPO);
    final heroData = {'id': 11, 'name': 'Mr. Nice'}; // ignore: always_specify_types
    expect(await po.selectedHero, heroData);
  });
}
