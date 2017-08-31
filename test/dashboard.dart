@Tags(const <String>['aot'])
@TestOn('browser')

import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_test/angular_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:angular_tour_of_heroes/app_component.dart';
import 'package:angular_tour_of_heroes/in_memory_data_service.dart';
import 'package:angular_tour_of_heroes/dashboard_component.dart';
import 'package:angular_tour_of_heroes/hero_service.dart';
import 'package:angular_tour_of_heroes/in_memory_data_service.dart';

import 'dashboard_po.dart';

/// Object that provides capability to test DashboardComponent
NgTestFixture<DashboardComponent> fixture;

/// Object to provide interactions with web UI
DashboardPO po;

/// Testable version of PlatformLocation
class MockPlatformLocation extends Mock implements PlatformLocation {}

///Instance of testable PlatformLocation
final MockPlatformLocation mockPlatformLocation = new MockPlatformLocation();

@AngularEntrypoint()
void main() {
  final providers = new List.from(ROUTER_PROVIDERS) // ignore: always_specify_types
    ..addAll([
      provide(APP_BASE_HREF, useValue: '/'),
      provide(Client, useClass: InMemoryDataService),
      provide(ROUTER_PRIMARY_COMPONENT, useValue: AppComponent),
      provide(PlatformLocation, useValue: mockPlatformLocation),
      HeroService,
    ]);
  final testBed = new NgTestBed<DashboardComponent>().addProviders(providers); // ignore: always_specify_types

  setUpAll(() async {
    when(mockPlatformLocation.pathname).thenReturn('');
    when(mockPlatformLocation.search).thenReturn('');
    when(mockPlatformLocation.hash).thenReturn('');
    when(mockPlatformLocation.getBaseHrefFromDOM()).thenReturn('');
  });

  setUp(() async {
    fixture = await testBed.create();
    po = await fixture.resolvePageObject(DashboardPO);
  });

  tearDown(disposeAnyRunningTest);

  test('title', () async {
    expect(await po.title, 'Top Heroes');
  });

  test('show top heroes', () async {
    final expectedNames = ['Narco', 'Bombasto', 'Celeritas', 'Magneta']; // ignore: always_specify_types
    expect(await po.heroNames, expectedNames);
  });

  test('select hero and navigate to detail', () async {
    clearInteractions(mockPlatformLocation);
    await po.clickHero(3);
    final c = verify(mockPlatformLocation.pushState(any, any, captureAny)); // ignore: always_specify_types
    expect(c.captured.single, '/detail/15');
  });

  test('no search no heroes', () async {
    expect(await po.heroesFound, <dynamic>[]);
  });

  group('Search hero:', heroSearchTests);
}

/// Group of tests related to searching heroes
void heroSearchTests() {
  final matchedHeroNames = [ // ignore: always_specify_types
    'Magneta',
    'RubberMan',
    'Dynama',
    'Magma',
  ];

  setUp(() async {
    await po.search.type('ma');
    await new Future<dynamic>.delayed(const Duration(seconds: 1));
    po = await fixture.resolvePageObject(DashboardPO);
  });

  test('list matching heroes', () async {
    expect(await po.heroesFound, matchedHeroNames);
  });
}
