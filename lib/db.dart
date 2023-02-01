import 'package:drift/drift.dart';
import 'package:drift/native.dart';

part 'db.g.dart';


// this annotation tells drift to prepare a database class that uses both of the
// tables we just defined. We'll see how to use that database class in a moment.
@DriftDatabase(
  include: {'tables.drift'},
)
class MyDb extends _$MyDb {
  // This example creates a simple in-memory database (without actual
  // persistence).
  // To store data, see the database setups from other "Getting started" guides.
  // TODO: switch to persistent db
  MyDb() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        await createGame(0, "Spy x Family Tamagotchi");
        await createGame(1, "Digital Monster X Version XC");
        await createShell(0, 0, "Anyatchi Pink");
        await createShell(1, 0, "SPY Green");
        await createShell(2, 1, "Red (Japanese)");
        await createShell(3, 1, "Translucent Red and Gold (English)");
        await createShell(4, 1, "Metallic Navy and Silver (English)");
      },
      // onUpgrade: (Migrator m, int from, int to) async {
      //   if (from < 2) {
      //     // we added the dueDate property in the change from version 1 to
      //     // version 2
      //     await m.addColumn(todos, todos.dueDate);
      //   }
      //   if (from < 3) {
      //     // we added the priority property in the change from version 1 or 2
      //     // to version 3
      //     await m.addColumn(todos, todos.priority);
      //   }
      // },
    );
  }
}