import '/model/model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;
 
  DatabaseHelper._internal() {
    _instance = this;
  }
 
  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();
 
  static const String _tblBookmark = 'Bookmarks';
 
  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/restaurantfav.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tblBookmark (
             id TEXT PRIMARY KEY,
             name TEXT,
             pictureId TEXT,
             description TEXT,
             city TEXT,             
             rating REAL           
           )     
        ''');
      },
      version: 1,
    );
 
    return db;
  }
 
  Future<Database?> get database async {
    _database ??= await _initializeDb();
 
    return _database;
  }

  Future<void> insertBookmark(getListRestaurant listRestaurant) async {
    final db = await database;
    await db!.insert(_tblBookmark, listRestaurant.toJson());
  }

  Future<List<getListRestaurant>> getBookmarks() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblBookmark);

    return results.map((res) => getListRestaurant.fromJson(res)).toList();
  }

  Future<Map> getBookmarkById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
      _tblBookmark,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeBookmark(String id) async {
    final db = await database;

    await db!.delete(
      _tblBookmark,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
