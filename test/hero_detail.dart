@Tags(const <String>['aot'])
@TestOn('browser')

import 'package:angular2/angular2.dart';
import 'package:angular2/platform/common.dart';
import 'package:angular2/router.dart';
import 'package:angular_test/angular_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:angular_tour_of_heroes/hero_detail_component.dart';
import 'package:angular_tour_of_heroes/hero_service.dart';

import 'hero_detail_po.dart';

/// Object that provides capability to test HeroDetailComponent
NgTestFixture<HeroDetailComponent> fixture;

/// Object to provide interactions with web UI
HeroDetailPO po;

/// Testable version of PlatformLocation
class MockPlatformLocation extends Mock implements PlatformLocation {}

///Instance of testable PlatformLocation
final MockPlatformLocation mockPlatformLocation = new MockPlatformLocation();

@AngularEntrypoint()
void main() {
  final baseProviders = new List.from(ROUTER_PROVIDERS) // ignore: always_specify_types
    ..addAll([
      provide(APP_BASE_HREF, useValue: '/'),
      provide(PlatformLocation, useValue: mockPlatformLocation),
      provide(RouteParams, useValue: new RouteParams({})), // ignore: always_specify_types
      HeroService,
    ]);
  final testBed = // ignore: always_specify_types
      new NgTestBed<HeroDetailComponent>().addProviders(baseProviders);

  tearDown(disposeAnyRunningTest);

  test('null initial @Input() hero has an empty view', () async {
    fixture = await testBed.create();
    po = await fixture.resolvePageObject(HeroDetailPO);
    expect(fixture.rootElement.text.trim(), '');
  });

  const targetHero = const {'id': 15, 'name': 'Magneta'}; // ignore: always_specify_types

  group('${targetHero['name']} initial @Input() hero:', () {
    final updatedHero = {'id': targetHero['id']}; // ignore: always_specify_types

    setUp(() async {
      final groupTestBed = testBed.fork().addProviders([ // ignore: always_specify_types
        provide(RouteParams, useValue: new RouteParams({'id': '15'}))
      ]);
      fixture = await groupTestBed.create();
      po = await fixture.resolvePageObject(HeroDetailPO);
    });

    test('shows hero details', () async {
      expect(await po.heroFromDetails, targetHero);
    });

    test('updates name', () async {
      const nameSuffix = 'X'; // ignore: always_specify_types
      updatedHero['name'] = "${targetHero['name']}$nameSuffix";
      await po.type(nameSuffix);
      expect(await po.heroFromDetails, updatedHero);
    });

    test('back button', () async {
      await po.back();
      verify(mockPlatformLocation.back());
    });
  });
}
