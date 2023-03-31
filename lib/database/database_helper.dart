import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static const _databaseName = 'daily_database';
  static const _databaseVersion = 1;

  static const table = 'daily_table';

  static const columnId = 'id';
  static const columnName = 'name';
  static const columnCategory = 'category';
  static const columnSun = 'sun';
  static const columnMon = 'mon';
  static const columnTue = 'tue';
  static const columnWed = 'wed';
  static const columnThu = 'thu';
  static const columnFri = 'fri';
  static const columnSat = 'sat';
  static const columnReminder = 'reminder';
  static const columnNote = 'note';
  static const columnLocation = 'location';

  late Database _db;

  Future<void> init() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, _databaseName);
    _db = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnCategory INTEGER NOT NULL,
            $columnSun BOOL NOT NULL,
            $columnMon BOOL NOT NULL,
            $columnTue BOOL NOT NULL,
            $columnWed BOOL NOT NULL,
            $columnThu BOOL NOT NULL,
            $columnFri BOOL NOT NULL,
            $columnSat BOOL NOT NULL,
            $columnReminder INTEGER NOT NULL,
            $columnNote TEXT NOT NULL,
            $columnLocation TEXT NOT NULL,
          )
          ''');
  }

  Future<int> insert(Daily daily) async {
    return await _db.insert(table, daily.toMap());
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    return await _db.query(table);
  }

  Future<int> delete(int id) async {
    return await _db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  Future<List?> tes() async {
    final List<Map<String, dynamic>> result = await _db.query(
      'my_table', // Table name
      limit: 1, // Limit to one row
    );
    if (result.isNotEmpty) {
      final List<dynamic> rowData = result.first.values.toList();
      return rowData;
    }
  }

  Future<List<Daily>> daily() async {
    final List<Map<String, dynamic>> maps = await _db.query(table, limit: 1);

    return List.generate(maps.length, (i) {
      return Daily(
        id: maps[i]['id'],
        name: maps[i]['name'],
        category: maps[i]['category'],
        sun: maps[i]['sun'],
        mon: maps[i]['mon'],
        tue: maps[i]['tue'],
        wed: maps[i]['wed'],
        thu: maps[i]['thu'],
        fri: maps[i]['fri'],
        sat: maps[i]['sat'],
        reminder: maps[i]['reminder'],
        note: maps[i]['note'],
        location: maps[i]['location'],
      );
    });
  }
}

class Daily {
  final int? id;
  final String name;
  final int category;
  final bool sun;
  final bool mon;
  final bool tue;
  final bool wed;
  final bool thu;
  final bool fri;
  final bool sat;
  final int reminder;
  final String note;
  final String location;

  Daily({
    this.id,
    required this.name,
    required this.category,
    required this.sun,
    required this.mon,
    required this.tue,
    required this.wed,
    required this.thu,
    required this.fri,
    required this.sat,
    required this.reminder,
    required this.note,
    required this.location,
  });

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnCategory: category,
      DatabaseHelper.columnSun: sun,
      DatabaseHelper.columnMon: mon,
      DatabaseHelper.columnTue: tue,
      DatabaseHelper.columnWed: wed,
      DatabaseHelper.columnThu: thu,
      DatabaseHelper.columnFri: fri,
      DatabaseHelper.columnSat: sat,
      DatabaseHelper.columnReminder: reminder,
      DatabaseHelper.columnNote: note,
      DatabaseHelper.columnLocation: location,
    };
  }
}
