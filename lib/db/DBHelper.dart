import 'dart:async';

import 'package:flutter_app/bean/BenifitMode.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static final DBHelper _instance = new DBHelper._internal();

  factory DBHelper() => _instance;
  static Database _db;

  DBHelper._internal(); // 一个私有的内部构造方法

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    // 获取路径，不同平台不一样
    var databasesPath = await getDatabasesPath();
    // 在对应的路径下创建数据库
    String path = join(databasesPath, 'bxh_flutter.db');

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    print("create_db");
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    var sql = 'CREATE TABLE $tableCollectImg('
        '$id INTEGER PRIMARY KEY,'
        '$createdAt TEXT,'
        '$desc TEXT,'
        '$publishedAt TEXT,'
        '$source TEXT,'
        '$type TEXT,'
        '$url TEXT,'
        '$used INTEGER,'
        '$who TEXT,'
        '$select INTEGER)';
    print("_onCreate,sql: $sql");
    await db.execute(sql);
  }

  // 表名
  final String tableCollectImg = 'img_table';
  final String id = "id";
  final String createdAt = "createdAt";
  final String desc = "desc";
  final String publishedAt = "publishedAt";
  final String source = "source";
  final String type = "type";
  final String url = "url";
  final String used = "used";
  final String who = "who";
  final String select = "select";

  Future<int> addCollectImgMode(BenifitMode mode) async {
    var dbClient = await db;
    var result = await dbClient.insert(tableCollectImg, mode.toJson());

    return result;
  }

  Future<int> delCollectImgMode(BenifitMode mode) async {
    var dbClient = await db;
    var result = await dbClient
        .delete(tableCollectImg, where: '$url = ?', whereArgs: [mode.url]);
    return result;
  }

  /// 查询是否收藏过，
  /// null: 没有收藏过
  /// 非null: 收藏过
  Future<BenifitMode> isCollectImgModeExist(BenifitMode mode) async {
    var dbClient = await db;
    var result = await dbClient.query(tableCollectImg,
        columns: [url], where: '$url = ?', whereArgs: [mode.url]);

    if (result.length > 0) {
      return new BenifitMode.fromJson(result.first);
    }
    return null;
  }
}
