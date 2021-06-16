import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'dart:io';

class DbProvider {
  Database db;

  init() async {
 
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "urls.db");
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
          CREATE TABLE urls(
            id INTEGER PRIMARY KEY,
            url TEXT UNIQUE
          )
        """);
      },
    );
  }

  Future<List<String>> buscarUrls() async {
    if(db == null)
    await init();
    List<Map> results = await db.query(
      'urls',
      columns: ['url'],
    );
    List<String> urls = [];
    results.forEach((Map<dynamic, dynamic> res) {
      urls.add(res['url']);
    });
    return urls;
  }

  addUrl(String url) async{
    if(db == null)
      await init();
    Map<String, dynamic> data = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'url': url
    };
    await db.insert('urls', data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  deleteUrl(String url) async{
    if(db == null)
      await init();
    var res = await db.rawDelete('DELETE FROM urls WHERE url = ?', [url]);
  }
}
