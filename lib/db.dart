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
}