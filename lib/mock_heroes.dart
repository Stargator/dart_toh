import 'hero.dart';

/// Initial way of declaring a list from tutorial
final mockHeroes = <Hero> [ // ignore: always_specify_types, type_annotate_public_apis
  new Hero(11, 'Mr. Nice'),
  new Hero(12, 'Narco'),
  new Hero(13, 'Bombasto'),
  new Hero(14, 'Celeritas'),
  new Hero(15, 'Magneta'),
  new Hero(16, 'RubberMan'),
  new Hero(17, 'Dynama'),
  new Hero(18, 'Dr IQ'),
  new Hero(19, 'Magma'),
  new Hero(20, 'Tornado')
];

/// Alternative way of declaring a list
final List<Hero> alternativeMockHeroes = [ // ignore: always_specify_types
  new Hero(22, 'Mr. Nice'),
  new Hero(23, 'Narco'),
  new Hero(24, 'Bombasto'),
  new Hero(25, 'Celeritas'),
  new Hero(26, 'Magneta'),
  new Hero(27, 'RubberMan'),
  new Hero(28, 'Dynama'),
  new Hero(29, 'Dr IQ'),
  new Hero(30, 'Magma'),
  new Hero(31, 'Tornado')];
