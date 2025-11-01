import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../modele/endroit.dart';

class EndroitsDatabase {
  static final EndroitsDatabase instance = EndroitsDatabase._init();
  static Database? _database;

  EndroitsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('endroits.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE endroits(
        id TEXT PRIMARY KEY,
        nom TEXT NOT NULL,
        description TEXT NOT NULL,
        image TEXT
      )
    ''');
  }

  Future<void> insertEndroit(Endroit endroit) async {
    final db = await instance.database;
    await db.insert(
      'endroits',
      endroit.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Endroit>> fetchAllEndroits() async {
    final db = await instance.database;
    final result = await db.query('endroits');
    return result.map((e) => Endroit.fromMap(e)).toList();
  }

  Future<void> deleteEndroit(String id) async {
    final db = await instance.database;
    await db.delete('endroits', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
