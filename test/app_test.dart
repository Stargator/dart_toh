@Tags(const ['aot'])
@TestOn('browser')

import 'package:angular2/angular2.dart';
import 'package:angular_test/angular_test.dart';
import 'package:test/test.dart';

import 'package:angular_tour_of_heroes/app_component.dart';
import 'package:angular_tour_of_heroes/hero.dart';

@AngularEntrypoint()
void main() {
  final testBed = new NgTestBed<AppComponent>();
  NgTestFixture<AppComponent> fixture;

  setUp(() async {
    fixture = await testBed.create();
  });

  tearDown(disposeAnyRunningTest);

  test('Default greeting', () {
    expect(fixture.text, 'Hello Angular');
  });

  test('Greet world', () async {
    await fixture.update((component) => component.selectedHero = new Hero(1, "Windstorm"));
    expect(fixture.text, 'Windstorm');
  });

  test('Greet world HTML', () {
    final html = fixture.rootElement.innerHtml;
    expect(html, '<h1>Hello Angular</h1>');
  });
}
