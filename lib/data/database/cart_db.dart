import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../services/error_message.dart';
import '../models/cart_item.dart';
import '../models/restaurant.dart';

class CartDb {
  static final CartDb instance = CartDb._init();
  static Database? _database;

  CartDb._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('cart2.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cart (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        productId TEXT,
        name TEXT,
        note TEXT,
        price1 REAL,
        price2 REAL,
        quantity INTEGER,
        image TEXT,
        vendorId TEXT,
        vendorName TEXT,
        cartType TEXT
      )
      ''');
    await db.execute('''
    CREATE TABLE selected_restaurant (
      id INTEGER PRIMARY KEY,
      categoryId TEXT,
      name TEXT,
      subName TEXT,
      deviceToken TEXT,
      type TEXT,
      isOpen INTEGER,
      active INTEGER,
      deliveryTime TEXT,
      tag TEXT,
      cover TEXT,
      logo TEXT,
      password TEXT,
      phone TEXT,
      address TEXT,
      date TEXT,
      discount REAL,
      deliveryPrice REAL,
      freeDelivery INTEGER,
      openTime TEXT,
      closeTime TEXT,
      starAvg REAL,
      cartType TEXT
    )
    ''');
  }

  Future<List<CartItem>> getAllItems() async {
    final db = await instance.database;
    final result = await db.query('cart');
    return result.map((e) => CartItem.fromMap(e)).toList();
  }

  Future<bool> isRestaurantDifferent(Restaurant restaurant) async {
    final db = await instance.database;

    final result = await db.query(
      'selected_restaurant',
      where: 'type = ?',
      whereArgs: [restaurant.type],
    );

    if (result.isEmpty) return false; // لا يوجد مطعم مخزن

    final existingId = result.first['id'];
    return existingId != restaurant.id; // true إذا مختلف، false إذا نفسه
  }

  Future<List<CartItem>> getItemsByCartType(String cartType) async {
    final db = await instance.database;
    final result = await db.query(
      'cart',
      where: 'cartType = ?',
      whereArgs: [cartType],
    );
    logger.e(result);
    return result.map((e) => CartItem.fromMap(e)).toList();
  }

  Future<void> insertItem(CartItem item) async {
    final db = await instance.database;
    await db.insert('cart', item.toMap());
  }

  Future<void> updateQuantity(String productId, int quantity) async {
    final db = await instance.database;
    await db.update(
      'cart',
      {'quantity': quantity},
      where: 'productId = ?',
      whereArgs: [productId],
    );
  }

  Future<void> deleteItem(String productId) async {
    final db = await instance.database;
    await db.delete('cart', where: 'productId = ?', whereArgs: [productId]);
  }

  Future<void> clearCart(String cartType, {String? type}) async {
    final db = await instance.database;
    await db.delete('cart', where: 'cartType = ?', whereArgs: [cartType]);
    if (type != null) {
      await db.delete(
        'selected_restaurant',
        where: 'type = ?',
        whereArgs: [type],
      );
    }
  }

  Future<void> saveRestaurant(Restaurant restaurant) async {
    final db = await instance.database;
    await db.delete(
      'selected_restaurant',
      where: 'type = ?',
      whereArgs: [restaurant.type],
    ); // احذف أي مطعم سابق
    await db.insert('selected_restaurant', _toMap(restaurant));
  }

  Future<bool> isRestaurantTypeExists(String type) async {
    final db = await instance.database;

    final result = await db.query(
      'selected_restaurant',
      where: 'type = ?',
      whereArgs: [type],
      limit: 1, // لا داعي لجلب كل النتائج، واحدة تكفي
    );
    logger.e(result);
    return result.isNotEmpty;
  }

  Future<Restaurant?> getRestaurant(String type) async {
    final db = await instance.database;
    final result = await db.query(
      'selected_restaurant',
      where: 'type = ?',
      whereArgs: [type],
      limit: 1,
    ); // لا داعي لجلب كل النتائج، واحدة تكفي);
    logger.f(result);

    if (result.isNotEmpty) {
      return Restaurant.fromJson({
        'shop': result.first,
        'starAvg': result.first['starAvg'],
      });
    }
    return null;
  }

  Future<void> clearRestaurant(String type) async {
    final db = await instance.database;
    await db.delete(
      'selected_restaurant',
      where: 'type = ?',
      whereArgs: [type],
    );
  }

  Map<String, dynamic> _toMap(Restaurant r) {
    return {
      'id': r.id,
      'categoryId': r.categoryId,
      'name': r.name,
      'subName': r.subName,
      'deviceToken': r.deviceToken,
      'type': r.type,
      'isOpen': r.isOpen ? 1 : 0,
      'active': r.active ? 1 : 0,
      'deliveryTime': r.deliveryTime,
      'tag': r.tag,
      'cover': r.cover,
      'logo': r.logo,
      'password': r.password,
      'phone': r.phone,
      'address': r.address,
      'date': r.date.toIso8601String(),
      'discount': r.discount,
      'deliveryPrice': r.deliveryPrice,
      'freeDelivery': r.freeDelivery ? 1 : 0,
      'openTime': r.openTime,
      'closeTime': r.closeTime,
      'starAvg': r.starAvg,
    };
  }
}
