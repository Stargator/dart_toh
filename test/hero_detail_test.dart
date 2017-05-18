@Tags(const <String>['aot'])
@TestOn('browser')

import 'package:angular2/angular2.dart';
import 'package:angular_test/angular_test.dart';

import 'package:test/test.dart';

import 'package:angular_tour_of_heroes/hero.dart';
import 'package:angular_tour_of_heroes/hero_detail_component.dart';

import 'hero_detail_po.dart';

/// Mock Hero details under test
const Map<String, dynamic> targetHero = const {'id': 1, 'name': 'Alice'}; // ignore: always_specify_types

/// Test fixture based on HeroDetailComponent
NgTestFixture<HeroDetailComponent> fixture;

/// Page Object for component of Hero Detail
HeroDetailPO heroDetailPo;

@AngularEntrypoint()
void main() {
  final testBed = new NgTestBed<HeroDetailComponent>(); // ignore: always_specify_types

  tearDown(disposeAnyRunningTest);

  group('Null initial @Input() hero:', () {
    setUp(() async {
      fixture = await testBed.create();
      heroDetailPo = await fixture.resolvePageObject(HeroDetailPO);
    });

    test('has empty view', () async {
      expect(fixture.rootElement.text.trim(), '');
    });

    test('transition to ${targetHero['name']} hero', () async {
      await fixture.update((comp) { // ignore: always_specify_types
        comp.hero = new Hero(targetHero['id'], targetHero['name']);
      });

      heroDetailPo = await fixture.resolvePageObject(HeroDetailPO);
      expect(await heroDetailPo.heroFromDetails, targetHero);
    });
  });

  group('${targetHero['name']} initial @Input() hero:', () {
    final updatedHero = {'id': targetHero['id']}; // ignore: always_specify_types

    setUp(() async {
      fixture = await testBed.create(
          beforeChangeDetection: (c) => // ignore: always_specify_types
              c.hero = new Hero(targetHero['id'], targetHero['name']));

      heroDetailPo = await fixture.resolvePageObject(HeroDetailPO);
    });

    test('show hero details', () async {
      expect(await heroDetailPo.heroFromDetails, targetHero);
    });

    test('update name', () async {
      const nameSuffix = 'X'; // ignore: always_specify_types
      updatedHero['name'] = "${targetHero['name']}$nameSuffix";
      await heroDetailPo.type(nameSuffix);
      expect(await heroDetailPo.heroFromDetails, updatedHero);
    });

    test('change name', () async {
      const newName = 'Bobbie'; // ignore: always_specify_types
      updatedHero['name'] = newName;
      await heroDetailPo.clear();
      await heroDetailPo.type(newName);
      expect(await heroDetailPo.heroFromDetails, updatedHero);
    });
  });
}
