import 'package:flutter/foundation.dart';
import '../providers/db_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class AppProvider with ChangeNotifier {
  DbProvider dbProvider = DbProvider();

  List<String> _urls = [];

  List<String> get urls => _urls;

  addUrl(String url) async {
    await dbProvider.addUrl(url);
    _urls.clear();
    _urls = await dbProvider.buscarUrls();
    notifyListeners();
  }

  deleteUrl(String url) async {
    await dbProvider.deleteUrl(url);
    _urls.clear();
    notifyListeners();
  }

  Future<bool> getUrls() async {
    _urls = await dbProvider.buscarUrls();
    return true;
  }

  Future<int> ping(String url) async {
    http.Response response = await http.get(url);
    if (response.statusCode < 200 || response.statusCode > 299) {
      return response.statusCode;
    }
    return 0;
  }
}
