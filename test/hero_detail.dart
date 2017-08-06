@Tags(const <String>['aot'])
@TestOn('browser')

import 'package:angular2/angular2.dart';
import 'package:angular2/platform/common.dart';
import 'package:angular2/router.dart';
import 'package:angular_test/angular_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:angular_tour_of_heroes/in_memory_data_service.dart';
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
      provide(Client, useClass: InMemoryDataService),
      provide(PlatformLocation, useValue: mockPlatformLocation),
      provide(RouteParams, useValue: new RouteParams({})), // ignore: always_specify_types
      HeroService,
    ]);
  final testBed = // ignore: always_specify_types
      new NgTestBed<HeroDetailComponent>().addProviders(baseProviders);

  setUp(() {
    InMemoryDataService.resetDb();
  });

  tearDown(disposeAnyRunningTest);

  test('null initial @Input() hero has an empty view', () async {
    fixture = await testBed.create();
    po = await fixture.resolvePageObject(HeroDetailPO);
    expect(fixture.rootElement.text.trim(), '');
  });

  const targetHero = const {'id': 15, 'name': 'Magneta'}; // ignore: always_specify_types

  group('${targetHero['name']} initial @Input() hero:', () {
    const nameSuffix = 'X'; // ignore: always_specify_types
    final updatedHero = {
      'id': targetHero['id'],
      'name': "${targetHero['name']}$nameSuffix"
    };

    setUp(() async {
      final groupTestBed = testBed.fork().addProviders([ // ignore: always_specify_types
        provide(RouteParams,
            useValue: new RouteParams({'id': targetHero['id'].toString()}))
      ]);
      fixture = await groupTestBed.create();
      po = await fixture.resolvePageObject(HeroDetailPO);
    });

    test('shows hero details', () async {
      expect(await po.heroFromDetails, targetHero);
    });

    test('back button', () async {
      await po.back();
      verify(mockPlatformLocation.back());
    });

    group('Update name:', () {
      setUp(() async {
        await po.type(nameSuffix);
      });

      test('show updated name', () async {
        expect(await po.heroFromDetails, updatedHero);
      });

      test('discard changes', () async {
        await po.back();
        verify(mockPlatformLocation.back());
        final name = InMemoryDataService.lookUpName(targetHero['id']);
        expect(name, targetHero['name']);
      });

      test('save changes and go back', () async {
        await po.save();
        verify(mockPlatformLocation.back());
        final name = InMemoryDataService.lookUpName(targetHero['id']);
        expect(name, updatedHero['name']);
      });
    });
  });
}
