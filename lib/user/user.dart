import 'package:isar/isar.dart';

part 'user.g.dart';

@collection
class OwnedShell {
  Id id = Isar.autoIncrement;

  late final String shellId;

  late String nickname;

  late bool currentlyOwned;

  @Backlink(to: 'ownedShell')
  final obtainedPet = IsarLinks<ObtainedPet>();
}

@collection
class ObtainedPet {
  Id id = Isar.autoIncrement;

  /// shell the pet was obtained on
  final ownedShell = IsarLink<OwnedShell>();

  /// for quick lookup of pets obtained for
  /// a given game
  late final String gameId;
}
