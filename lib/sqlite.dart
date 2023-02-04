import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'checkin.dart';
import 'package:giuxe/search.dart';

void droptable() async {

  WidgetsFlutterBinding.ensureInitialized();

  final database = openDatabase(

    join(await getDatabasesPath(), 'giuxe.db'),

    onCreate: (db, version) {

      return db.execute(
        'DROP TABLE danhsach',
      );
    },

    version: 1,
  );
  final db= await database;
  db.delete('danhsach');



}
void deletedata(int idNguoigui) async {

  WidgetsFlutterBinding.ensureInitialized();

  final database = openDatabase(

    join(await getDatabasesPath(), 'giuxe.db'),

    onCreate: (db, version) {

      return db.execute(
        'CREATE TABLE danhsach(id INTEGER PRIMARY KEY, mathe TEXT, time TEXT)',
      );
    },

    version: 1,
  );


  Future<List<danhsach>> laytoanbo() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('danhsach');
    return List.generate(maps.length, (i) {
      return danhsach(
        id: maps[i]['id'],
        mathe: maps[i]['mathe'],
        time: maps[i]['time'],
      );
    });
  }
  Future<void> deleteNguoigui(int id) async {
    final db = await database;
    await db.delete(
      'danhsach',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  await deleteNguoigui(idNguoigui);
  print(await laytoanbo());

}
void getdata() async {

  WidgetsFlutterBinding.ensureInitialized();

  final database = openDatabase(

    join(await getDatabasesPath(), 'giuxe.db'),

    onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE thexe(mathe TEXT, hoatdong INTEGER, id INTEGER)',
      );
      return db.execute(
        'CREATE TABLE danhsach(id INTEGER PRIMARY KEY, mathe TEXT, time TEXT)',
      );
    },

    version: 1,
  );

  Future<void> insertNguoigui(danhsach nguoigui) async {

    final db = await database;

    await db.insert(
      'danhsach',
      nguoigui.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<danhsach>> laytoanbo() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('danhsach');
    return List.generate(maps.length, (i) {
      return danhsach(
        id: maps[i]['id'],
        mathe: maps[i]['mathe'],
        time: maps[i]['time'],
      );
    });
  }

  Future<void> updateNguoigui(danhsach nguoigui) async {
    final db = await database;
    await db.update(
      'danhsach',
      nguoigui.toMap(),
      where: 'id = ?',
      whereArgs: [nguoigui.id],
    );
  }

  Future<void> deleteNguoigui(int id) async {
    final db = await database;
    await db.delete(
      'danhsach',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  print(await laytoanbo());

}
void insertdata() async {

  WidgetsFlutterBinding.ensureInitialized();

  final database = openDatabase(

    join(await getDatabasesPath(), 'giuxe.db'),

    onCreate: (db, version) {

      return db.execute(
        'CREATE TABLE danhsach(id INTEGER PRIMARY KEY, mathe TEXT, time TEXT)',
      );
    },

    version: 1,
  );

  Future<void> insertNguoigui(danhsach nguoigui) async {

    final db = await database;

    await db.insert(
      'danhsach',
      nguoigui.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<danhsach>> laytoanbo() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('danhsach');
    return List.generate(maps.length, (i) {
      return danhsach(
        id: maps[i]['id'],
        mathe: maps[i]['mathe'],
        time: maps[i]['time'],
      );
    });
  }

  var nguoigui00 = danhsach(
    id: id,
    mathe: mathe,
    time: time.toString(),
  );

  await insertNguoigui(nguoigui00);
  print(await laytoanbo());

}
List<Map<String, dynamic>> newmaps=[];
Future<List<danhsach>> getdatawithdate() async {

  WidgetsFlutterBinding.ensureInitialized();

  final database = openDatabase(

    join(await getDatabasesPath(), 'giuxe.db'),

    onCreate: (db, version) {

      return db.execute(
        'CREATE TABLE danhsach(id INTEGER PRIMARY KEY, mathe TEXT, time TEXT)',
      );
    },

    version: 1,
  );


  Future<List<danhsach>> laytoanbo() async {
    newmaps.clear();
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('danhsach');

    for(int i=0;i<maps.length;i++)
      {
        if(DateTime.parse(maps[i]['time']).millisecondsSinceEpoch>=datetime1.millisecondsSinceEpoch&&DateTime.parse(maps[i]['time']).millisecondsSinceEpoch<=datetime2.millisecondsSinceEpoch) newmaps.add(maps[i]);
      }
    return List.generate(newmaps.length, (i) {
      return danhsach(
        id: newmaps[i]['id'],
        mathe: newmaps[i]['mathe'],
        time: newmaps[i]['time'],
      );

    });
  }


  print(await laytoanbo());
  return laytoanbo();

}
class danhsach {
  final int id;
  final String mathe;
  final time;

  danhsach({
    required this.id,
    required this.mathe,
    required this.time,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mathe': mathe,
      'time': time,
    };
  }
  @override
  String toString() {
    return 'danhsach{id: $id, mathe: $mathe, time :$time}';
  }

}
// database cho the xe//
Future<List<checkthe>> hoatdongthe() async {

  WidgetsFlutterBinding.ensureInitialized();

  final database = openDatabase(

    join(await getDatabasesPath(), 'giuxe.db'),

    onCreate: (db, version) {

      return db.execute(
        'CREATE TABLE thexe(mathe TEXT PRIMARY KEY, hoatdong INTEGER, id INTEGER)',
      );
    },

    version: 1,
  );


  Future<List<checkthe>> laytoanbo() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('thexe');

    return List.generate(maps.length, (i) {
      return checkthe(
        mathe: maps[i]['mathe'],
        id: maps[i]['id'],
        hoatdong: maps[i]['hoatdong'],
      );

    });
  }
  print(await laytoanbo());
  return laytoanbo();

}
Future<List<checkthe>> insertthe() async {

  WidgetsFlutterBinding.ensureInitialized();

  final database = openDatabase(

    join(await getDatabasesPath(), 'giuxe.db'),

    onCreate: (db, version) {

      return db.execute(
        'CREATE TABLE thexe(mathe TEXT PRIMARY KEY, hoatdong INTEGER, id INTEGER)',
      );
    },

    version: 1,
  );


  Future<List<checkthe>> laytoanbo() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('thexe');

    return List.generate(maps.length, (i) {
      return checkthe(
        mathe: maps[i]['mathe'],
        id: maps[i]['id'],
        hoatdong: maps[i]['hoatdong'],
      );

    });
  }
  Future<void> insertthe(checkthe nguoigui) async {

    final db = await database;

    await db.insert(
      'thexe',
      nguoigui.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  var nguoigui00 = checkthe(
    id: id,
    mathe: mathe,
    hoatdong: 1,
  );
  insertthe(nguoigui00);
  print(await laytoanbo());
  return laytoanbo();

}
Future<List<checkthe>> updatethe() async {

  WidgetsFlutterBinding.ensureInitialized();

  final database = openDatabase(

    join(await getDatabasesPath(), 'giuxe.db'),

    onCreate: (db, version) {

      return db.execute(
        'CREATE TABLE thexe(mathe TEXT PRIMARY KEY, hoatdong INTEGER, id INTEGER)',
      );
    },

    version: 1,
  );


  Future<List<checkthe>> laytoanbo() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('thexe');

    return List.generate(maps.length, (i) {
      return checkthe(
        mathe: maps[i]['mathe'],
        id: maps[i]['id'],
        hoatdong: maps[i]['hoatdong'],
      );

    });
  }

  Future<void> updateNguoigui(checkthe nguoigui) async {
    final db = await database;
    await db.update(
      'thexe',
      nguoigui.toMap(),
      where: 'mathe = ?',
      whereArgs: [nguoigui.mathe],
    );
  }
  var nguoigui00 = checkthe(
    id: id,
    mathe: mathe,
    hoatdong: 1,
  );
  updateNguoigui(nguoigui00);
  print(await laytoanbo());
  return laytoanbo();

}
class checkthe {
  final int id;
  final String mathe;
  final int hoatdong;

  checkthe({
    required this.id,
    required this.mathe,
    required this.hoatdong,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'mathe': mathe,
      'hoatdong': hoatdong,
    };
  }
  @override
  String toString() {
    return 'thexe{id: $id, mathe: $mathe, hoatdong :$hoatdong}';
  }

}