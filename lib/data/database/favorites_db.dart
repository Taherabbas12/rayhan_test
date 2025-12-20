import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/favorite_product_model.dart';

class FavoritesDb {
  static final FavoritesDb instance = FavoritesDb._init();
  static Database? _database;

  FavoritesDb._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('favorites4.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return openDatabase(
      path,
      version: 3,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

  Future<bool> toggleFavorite(FavoriteProduct product) async {
    final exists = await this.exists(product.id);

    if (exists) {
      await removeFavorite(product.id);
      return false;
    } else {
      await addFavorite(product);
      return true;
    }
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorite_products (
        id INTEGER PRIMARY KEY,
        name TEXT,
        descc TEXT,
        curncy TEXT,
        active INTEGER,
        count TEXT,
        image TEXT,
        price1 REAL,
        price2 REAL,
        shopType TEXT,
        vendorId TEXT,
        vendorName TEXT
      )
    ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 3) {
      await db.execute(
        "ALTER TABLE favorite_products ADD COLUMN vendorId TEXT",
      );
      await db.execute(
        "ALTER TABLE favorite_products ADD COLUMN vendorName TEXT",
      );
    }
  }

  /* ================= CRUD ================= */

  Future<void> addFavorite(FavoriteProduct product) async {
    final db = await instance.database;
    await db.insert(
      'favorite_products',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeFavorite(int id) async {
    final db = await instance.database;
    await db.delete('favorite_products', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<FavoriteProduct>> getAll() async {
    final db = await instance.database;
    final result = await db.query('favorite_products');
    return result.map((e) => FavoriteProduct.fromMap(e)).toList();
  }

  Future<bool> exists(int id) async {
    final db = await instance.database;
    final result = await db.query(
      'favorite_products',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return result.isNotEmpty;
  }
}
