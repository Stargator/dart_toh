@Skip('AppComponent tests need bootstrap equivalent for the Router init')
@Tags(const ['aot']) // ignore: always_specify_types
@TestOn('browser')

import 'package:angular/angular.dart';
import 'package:angular_router/angular_router.dart';
import 'package:angular_test/angular_test.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

import 'package:angular_tour_of_heroes/app_component.dart';

import 'app_po.dart';

/// Object that provides capability to test AppComponent
NgTestFixture<AppComponent> fixture;

/// Object mocking the AppComponent
AppPO appPO;

/// Testable version of PlatformLocation
class MockPlatformLocation extends Mock implements PlatformLocation {}

///Instance of testable PlatformLocation
final MockPlatformLocation mockPlatformLocation = new MockPlatformLocation();

@AngularEntrypoint()
void main() {
  final providers = [ // ignore: always_specify_types
    provide(APP_BASE_HREF, useValue: '/'),
    provide(ROUTER_PRIMARY_COMPONENT, useValue: AppComponent),
    provide(PlatformLocation, useValue: mockPlatformLocation),
  ];

  final testBed = new NgTestBed<AppComponent>().addProviders(providers); // ignore: always_specify_types

  setUpAll(() async {
    // Seems like we'd need to do something equivalent to:
    // bootstrap(AppComponent);
  });

  setUp(() async {
    fixture = await testBed.create();
    // PO fields are bound at the time the PO instance is created, based on the
    // state of the fixture’s component’s view. Once bound, they do not change.
    appPO = await fixture.resolvePageObject(AppPO);
  });

  tearDown(disposeAnyRunningTest);

  group('Basics:', basicTests);
//  group('Bad Tests:', badTests); // Do NOT run these tests
}

/// Group of simple tests
void basicTests() {
  test('Page Title from Page Object', () async {
    expect(await appPO.pageTitle, 'Tour of Heroes');
  });

  test('tab titles', () async {
    final expectTitles = ['Dashboard', 'Heroes']; // ignore: always_specify_types
    expect(await appPO.tabTitles, expectTitles);
  });
}
