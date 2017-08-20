@Tags(const ['aot'])
@TestOn('browser')

import 'dart:async';

import 'package:angular2/angular2.dart';
import 'package:angular_test/angular_test.dart';
import 'package:pageloader/objects.dart';
import 'package:test/test.dart';

import 'package:angular_tour_of_heroes/app_component.dart';

/// Page Object for Application
class AppPO {
  @ByTagName('h1')
  PageLoaderElement _title;

  @FirstByCss('div')
  PageLoaderElement _id;

  @ByTagName('h2')
  PageLoaderElement _name;

  @ByTagName('input')
  PageLoaderElement _input;

  /// Component's title
  Future<String> get title => _title.visibleText;

  /// Id of listed Hero Object
  Future<int> get heroId async {
    final idAsString = (await _id.visibleText).split(' ')[1];
    return int.parse(idAsString, onError: (_) => -1);
  }

  /// Name of listed Hero Object
  Future<String> get heroName async {
    final text = await _name.visibleText;
    return text.substring(0, text.lastIndexOf(' '));
  }

  /// Input Value
  Future<String> type(String s) => _input.type(s);
}

@AngularEntrypoint()
void main() {
  final testBed = new NgTestBed<AppComponent>();
  NgTestFixture<AppComponent> fixture;
  AppPO appPO;
  const windstormData = const <String, dynamic>{'id': 1, 'name': 'Windstorm'};

  setUp(() async {
    fixture = await testBed.create();
    // PO fields are bound at the time the PO instance is created, based on the
    // state of the fixture’s component’s view. Once bound, they do not change.
    appPO = await fixture.resolvePageObject(AppPO);
  });

  tearDown(() async {
    fixture = null;
    await disposeAnyRunningTest();
  });

  test('Default Title from Page Object', () async {
    expect(await appPO.title, 'Tour of Heroes');
  });

  test('initial hero properties', () async {
    expect(await appPO.heroId, windstormData['id']);
    expect(await appPO.heroName, windstormData['name']);
  });

  test('update hero name', () async {
    const nameSuffix = 'X';

    await appPO.type(nameSuffix);
    expect(await appPO.heroId, windstormData['id']);
    expect(await appPO.heroName, "${windstormData['name']}$nameSuffix");
  });

  // Not a test we want to do.
  test('Use fixture to get innerHTMLL', () {
    final html = fixture.rootElement.innerHtml;
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
    await fixture.update((c) => c.hero = new Hero(1, "Windstorm"));
    expect(fixture.text, '''
    Tour of Heroes
    Windstorm details!
    id: 1
    
      name: 
      
    
    ''');
  });
}
