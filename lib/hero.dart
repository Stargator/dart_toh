/// Hero class used to define all the heroes
class Hero {
  /// Hero's unique id
  final int id;

  /// Hero's avenging name
  String name;

  /// A hero's origin
  Hero(this.id, this.name);

  factory Hero.fromJson(Map<String, dynamic> hero) =>
      new Hero(_toInt(hero['id']), hero['name']);

  Map toJson() => {'id': id, 'name': name};
}

  int _toInt(id) => id is int ? id : int.parse(id);