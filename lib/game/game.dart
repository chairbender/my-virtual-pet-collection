import 'package:dart_mappable/dart_mappable.dart';

part 'game.mapper.dart';

@MappableClass()
class GameList with GameListMappable {
  final List<Game> games;
  const GameList(this.games);
}

@MappableClass(discriminatorKey: 'type')
abstract class Game with GameMappable {
  final String id;
  final List<Link> links;
  final Names names;
  final List<Pet> pets;
  final List<Shell> shells;

  const Game(this.id, this.links, this.names, this.pets, this.shells);
}

@MappableClass()
class Link with LinkMappable {
  final String name;
  final String url;

  const Link(this.name, this.url);
}

@MappableClass()
class Names with NamesMappable {
  final String? en;
  final String? enShort;
  final String? ja;
  final String? romaji;

  const Names(this.en, this.enShort, this.ja, this.romaji);

  String name() {
    return enShort ?? en ?? ja ?? romaji ?? "<UNKNOWN>";
  }
}

@MappableClass(discriminatorValue: null)
class BasicGame extends Game with BasicGameMappable {
  const BasicGame(super.id, super.links, super.names, super.pets, super.shells);
}

@MappableClass(discriminatorKey: 'type')
abstract class Pet with PetMappable {
  final String id;
  final Names names;

  const Pet(this.id, this.names);
}

@MappableClass(discriminatorValue: null)
class BasicPet extends Pet with BasicPetMappable {
  BasicPet(super.id, super.names);
}

@MappableClass()
class Shell with ShellMappable {
  final String id;
  final Names names;

  const Shell(this.id, this.names);
}
