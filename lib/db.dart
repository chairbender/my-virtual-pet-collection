import 'package:drift/drift.dart';

part 'db.g.dart';

/// The actual gameplay - the board with a particular ROM. One board
/// has 1 or more different shells, and 1 or more different pets.
class Game extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(max: 1024)();
}

/// External shell / color.
class Shell extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(max: 1024)();
  TextColumn get thumbnailImagePath => text().withLength(max: 1024)();
  IntColumn get gameId => integer().customConstraint('REFERENCES game(id)')();
}

/// Base table for all obtainable pets. A pet is an obtainable creature in a particular game.
/// Even if a particular named pet appears on multiple games, it is still a
/// different "pet" entry.
class Pet extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(max: 1024)();
  TextColumn get thumbnailImagePath => text().withLength(max: 1024)();
  IntColumn get gameId => integer().customConstraint('REFERENCES game(id)')();
}

/// Devices owned or otherwise tracked by the user.
/// Note a user could own multiple of a given game + shell.
class OwnedShell extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get shellId => integer().customConstraint('REFERENCES shell(id)')();
  // TODO: status (owned, want to buy, etc...), custom labels, condition, etc...
}

/// Pets obtained or otherwise tracked by the user, on a given owned shell
class ObtainedPet extends Table {
  IntColumn get ownedShellId => integer().customConstraint('REFERENCES ownedshell(id)')();
  IntColumn get petId => integer().customConstraint('REFERENCES pet(id)')();
  // TODO: different statuses (owned, goal, etc...)

  @override
  Set<Column> get primaryKey => {ownedShellId, petId};
}

// this annotation tells drift to prepare a database class that uses both of the
// tables we just defined. We'll see how to use that database class in a moment.
@DriftDatabase(tables: [Shell])
class MyDatabase extends _$MyDatabase {

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        // add all of the data
      },
      onUpgrade: (Migrator m, int from, int to) async {
        /*if (from < 2) {
          // we added the dueDate property in the change from version 1 to
          // version 2
          await m.addColumn(todos, todos.dueDate);
        }*/
      },
    );
  }
}