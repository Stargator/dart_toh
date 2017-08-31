@Tags(const <String>['aot'])
@TestOn('browser')

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_test/angular_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:angular_tour_of_heroes/heroes_component.dart';
import 'package:angular_tour_of_heroes/hero_service.dart';
import 'package:angular_tour_of_heroes/in_memory_data_service.dart';

import 'heroes_po.dart';
import 'utils.dart';

/// Number of Heroes to display
const int numHeroes = 10;

/// Index to find Hero in list
const int targetHeroIndex = 4; // index in full heroes list

/// Mock Hero object
const Map<String, Object> targetHero = const <String, Object>{'id': 15, 'name': 'Magneta'};

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
  group('Add hero:', addHeroTests);
  group('Delete hero:', deleteHeroTests);
}

/// Group of simple tests
void basicTests() {
  test('title', () async {
    expect(await po.title, 'My Heroes');
  });

  test('hero count', () async {
    await fixture.update();
    expect(po.heroes.length, numHeroes);
  });

  test('no selected hero', () async {
    expect(await po.selectedHero, null);
  });
}

/// Group of tests related to selecting a hero
void selectedHeroTests() {
  setUp(() async {
    await po.clickHero(targetHeroIndex);
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

/// Group of rests for adding Heroes
void addHeroTests() {
  const newHeroName = 'Carl'; // ignore: always_specify_types

  setUp(() async {
    await po.addHero(newHeroName);
    po = await fixture.resolvePageObject(HeroesPO);
  });

  test('hero count', () async {
    expect(po.heroes.length, numHeroes + 1);
  });

  test('select new hero', () async {
    await po.clickHero(numHeroes);
    po = await fixture.resolvePageObject(HeroesPO);
    expect(po.heroes.length, numHeroes + 1);
    expect((await po.selectedHero)['name'], newHeroName);
    expect(await po.myHeroNameInUppercase, equalsIgnoringCase(newHeroName));
  });
}

/// Group of tests of deleting Heroes
void deleteHeroTests() {
  var heroesWithoutTarget = []; // ignore: always_specify_types

  setUp(() async {
    heroesWithoutTarget = await inIndexOrder(po.heroes).toList()
      ..removeAt(targetHeroIndex);
    await po.deleteHero(targetHeroIndex);
    po = await fixture.resolvePageObject(HeroesPO);
  });

  test('hero count', () async {
    expect(po.heroes.length, numHeroes - 1);
  });

  test('heroes left', () async {
    expect(await inIndexOrder(po.heroes).toList(), heroesWithoutTarget);
  });
}
