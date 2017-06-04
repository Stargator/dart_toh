import 'dart:async';

/// Convert Hero data in string to proper types
Map<String, dynamic> heroData(String idAsString, String name) =>
    {'id': int.parse(idAsString, onError: (_) => -1), 'name': name}; // ignore: always_specify_types

/// I have no idea what this is for
Stream<T> inIndexOrder<T>(Iterable<Future<T>> futures) async* {
  for (var x in futures) { // ignore: always_specify_types
    yield await x;
  }
}
