/// Hero class used to define all the heroes
class Hero {
  /// Hero's unique id
  final int id;

  /// Hero's avenging name
  String name;

  /// A hero's origin
  Hero(this.id, this.name);

  /// Convert JSON to Hero object
  factory Hero.fromJson(Map<String, dynamic> hero) =>
      new Hero(_toInt(hero['id']), hero['name']);

  /// Convert Hero object to JSON
  Map<String, dynamic> toJson() => <String, dynamic>{'id': id, 'name': name};
}

int _toInt(String id) => id is int ? id : int.parse(id);
