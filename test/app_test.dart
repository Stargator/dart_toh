@Tags(const ['aot']) // ignore: always_specify_types
@TestOn('browser')

import 'package:angular2/angular2.dart';
import 'package:angular_test/angular_test.dart';

import 'package:test/test.dart';

import 'package:angular_tour_of_heroes/heroes_component.dart';
import 'package:angular_tour_of_heroes/hero.dart'; // Only Used for Bad Test

import 'app_po.dart';

/// Object that provides capability to test HeroesComponent
NgTestFixture<HeroesComponent> fixture;

/// Object mocking the AppComponent
AppPO appPO;

@AngularEntrypoint()
void main() {
  final testBed = new NgTestBed<HeroesComponent>(); // ignore: always_specify_types

  setUp(() async {
    fixture = await testBed.create();
    // PO fields are bound at the time the PO instance is created, based on the
    // state of the fixture’s component’s view. Once bound, they do not change.
    appPO = await fixture.resolvePageObject(AppPO);
  });

  tearDown(disposeAnyRunningTest);

  group('Basics:', basicTests);
  group('Select hero:', selectHeroTests);
//  group('Bad Tests:', badTests); // Do NOT run these tests
}

/// Group of simple tests
void basicTests() {
  test('Page Title from Page Object', () async {
    expect(await appPO.pageTitle, 'Tour of Heroes');
  });

  test('tab title', () async {
    expect(await appPO.tabTitle, 'My Heroes');
  });

  test('hero count', () {
    expect(appPO.heroes.length, 10);
  });

  test('no selected hero', () async {
    expect(await appPO.selectedHero, null);
  });
}

/// Group of tests related to selecting a hero
void selectHeroTests() {
  const targetHero = const {'id': 16, 'name': 'RubberMan'}; // ignore: always_specify_types

  setUp(() async {
    await appPO.clickHero(5);
    appPO = await fixture.resolvePageObject(AppPO); // Refresh PO
  });

  test('is selected', () async {
    expect(await appPO.selectedHero, targetHero);
  });

  test('show hero details', () async {
    expect(await appPO.heroFromDetails, targetHero);
  });

//    expect(await appPO.heroName, targetHero['name'] + nameSuffix);
  group('Update hero:', () {
    const nameSuffix = 'X'; // ignore: always_specify_types
    final updatedHero = new Map.from(targetHero);
    updatedHero['name'] = "${targetHero['name']}$nameSuffix";

    setUp(() async {
      await appPO.type(nameSuffix);
    });

    tearDown(() async {
      // Restore hero name
      await appPO.clear();
      await appPO.type(targetHero['name']);
    });

    test('name in list is updated', () async {
      expect(await appPO.selectedHero, updatedHero);
    });

    test('name in details view is updated', () async {
      expect(await appPO.heroFromDetails, updatedHero);
    });
  });
}

/// Collection of tests that are fragile
void badTests() {

  // Not a test we want to do.
  test('Use fixture to get innerHTMLL', () {
    final html = fixture.rootElement.innerHtml; // ignore: always_specify_types
    expect(html, '''
    <h1>Tour of Heroes</h1>
    <h2>Windstorm details!</h2>
    <div><label>id: </label>1</div>
    <div>
      <label>name: </label>
      <input placeholder="name">
    </div>
    ''');
  });

  // Not a test we want to do.
  test('Name of Hero', () async {
    await fixture.update((component) => component.selectedHero = new Hero(1, "Windstorm")); // ignore: always_specify_types
    expect(fixture.text, '''
    Tour of Heroes
    Windstorm details!
    id: 1
    
      name: 
      
    
    ''');
  });
}