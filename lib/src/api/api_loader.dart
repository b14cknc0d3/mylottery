import 'package:my_lottery/src/model/saledata_item.dart';
import 'package:my_lottery/src/model/search_result_list.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_provider.dart';

class ApiLoader {
  final ApiProvider client;

  ApiLoader(this.client);

  Future<SearchResult> search(String term) async {
    final result = await client.searchSale(term);

    print('result.items from apiLoader:${result.oneLs.length}');
    return result;
  }

  Future<List<OneLs>> getSaleData() async {
    final result = await client.getItem();
    print(result);
    return result;
  }

  Future<void> doLogin(String username, String password) async {
    print('void doLogin call');
    await  client.login(username, password);
//    print('doLogin :$username : $password');
//    await client.login(username, password);
////    print(key);
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
    final v = prefs.getString(k) ;
    if(v == null ){
      return false;
    }else{
      return true;
    }
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
