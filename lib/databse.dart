import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databaseName = 'photos.db';
  static final _databaseVersion = 1;

  static final table = 'photos';
  static final columnId = 'id';
  static final columnImagePath = 'imagePath';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getDatabasesPath();
    final path = join(documentsDirectory, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnImagePath TEXT
      )
    ''');
  }

  Future<int> insert(String imagePath) async {
    final db = await database;
    return await db!.insert(table, {columnImagePath: imagePath});
  }

  Future<List<Map<String, dynamic>>?> queryAll() async {
    final db = await database;
    return await db!.query(table);
  }

  Future<int> delete(String imagePath) async {
    final db = await database;
    return await db!.delete(table, where: '$columnImagePath = ?', whereArgs: [imagePath]);
  }
}
