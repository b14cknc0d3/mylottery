import 'package:my_lottery/src/model/saledata_item.dart';
import 'package:my_lottery/src/model/search_result_list.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_provider.dart';

class ApiLoader {
  final ApiProvider client;

  ApiLoader(this.client);

  Future<SearchSale> search(String term) async {
    final result = await client.searchSale(term);

    print(result);
    return result;
  }

  Future<List<SaleData>> getSaleData() async {
    final result = await client.getItem();
    print(result);
    return result;
  }

  Future<void> doLogin(String username, String password) async {
    print('doLogin :$username : $password');
    await client.login(username, password);
//    print(key);
//    if (key.contains(null)) {
//      print(null.toString());
//    } else if (key.contains('0')) {
//      print('Error while Login');
//    }
//    saveKey(key);
//    return key;
  }

  Future<bool> hasKey() async {
    final prefs = await SharedPreferences.getInstance();
    final k = 'key';
    final v = prefs.getString(k) ?? null;
    return v != null;
  }

  Future<String> readKey() async {
    final prefs = await SharedPreferences.getInstance();
    final k = 'key';
    final v = prefs.getString(k) ?? null;
    return v;
  }

  Future<void> deleteKey() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<void> saveKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final k = 'key';
    final v = key;
    prefs.setString(k, v);
  }
}
