import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_sqlite/models/item.dart';

class DbHelper {
  static DbHelper? _dbHelper;
  static Database? _database;
  DbHelper._createObject();

  //untuk menentukan nama database dan lokasi yg dibuat
  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}items.db';

    //create, read databases
    var itemDatabase = openDatabase(path, version: 1, onCreate: _createDb);

    //mengembalikan nilai object sebagai hasil dari fungsinya
    return itemDatabase;
  }

  //buat tabel baru dengan nama item
  void _createDb(Database db, int version) async {
    await db.execute('''
        CREATE TABLE item (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        price INTEGER,
        stock INTEGER,
        kodeBarang TEXT
        )
      ''');
  }

  Future<List<Map<String, dynamic>>> select() async {
    Database db = await initDb();
    var mapList = await db.query('item', orderBy: 'name');
    return mapList;
  }

  //create databases
  Future<int> insert(Item object) async {
    Database db = await initDb();
    int count = await db.insert('item', object.toMap());
    return count;
  }

  //update databases
  Future<int> update(Item object) async {
    Database db = await initDb();
    int count = await db
        .update('item', object.toMap(), where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  //delete databases
  Future<int> delete(int id) async {
    Database db = await initDb();
    int count = await db.delete('item', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<List<Item>> getItemList() async {
    var itemMapList = await select();
    int count = itemMapList.length;
    List<Item> itemList = <Item>[];
    for (int i = 0; i < count; i++) {
      itemList.add(Item.fromMap(itemMapList[i]));
    }
    return itemList;
  }

  factory DbHelper() {
    _dbHelper ??= DbHelper._createObject();
    return _dbHelper!;
  }

  Future<Database> get database async {
    _database ??= await initDb();
    return _database!;
  }
}