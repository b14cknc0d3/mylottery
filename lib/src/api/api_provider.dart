import 'dart:convert';

import 'package:my_lottery/src/model/saledata_item.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiProvider {
  static final baseUrl = 'http://yla-heroku.herokuapp.com';
  static final loginUrl = '$baseUrl/auth/login/';

  Future<String> login(String username, String password) async {
    final response = await Future.delayed(
        Duration(seconds: 2),
        () => http.post('$loginUrl',
            headers: {"Accept": "application/json"},
            body: {"username": "$username", "password": "$password"}));
    print('POST BODY:$username : $password');

    var data = json.decode(response.body);
    print('KEy:${data['key']}');
    var haskey = response.body.contains('key');
    var key = data['key'];
    if (response.statusCode != 200 || !haskey) {
      print('!== 200 or not key');
    }
    if (response.statusCode == 200 && haskey) {
      _saveKey(key);
      print('Key_save_called:$key');
      return key;
    }
    return '0';
  }

  Future<SearchResult> searchSale(String term) async {
    final response = await http.get(
        '$baseUrl/api/saledatas/search/one/?filter{lno.icontains}=$term&filter{is_winner.icontains}=1&exclude[]=phone&exclude[]=created_at',
        headers: {
          "Accept": "application/json",
          'Authorization': 'Token f6c3e63f1a95b0709d2b70075d0d592e0c4a5f85'
        });

    final data = json.decode(utf8.decode(response.bodyBytes));
    print('DATA :$data');
    if (response.statusCode == 200) {
      final res = SearchResult.fromJson(data);
      print('Result :${res.oneLs}');
      return res;
    } else {
      //print('Erro : not 200');
      throw Exception('Error No Results');
    }
  }

  Future<List<OneLs>> getItem() async {
    final response = await http.get('$baseUrl/one/', headers: {
      "Accept": "application/json",
      'Authorization': 'Token f6c3e63f1a95b0709d2b70075d0d592e0c4a5f85'
    });
    final data = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode == 200) {
      print('SALEDATA:$data');
      return parsedJson(data);
    } else {
      return null;
    }
  }

  void _saveKey(key) async {
    Future.delayed(Duration(seconds: 2));
    if (key != null || key != '0') {
      final prefs = await SharedPreferences.getInstance();
      final k = 'key';
      final v = key;
      print('Saving...key ;$v');
      prefs.setString(k, v);
    } else {
      final prefs = await SharedPreferences.getInstance();
      final k = 'key';

      prefs.remove(k);
    }
  }
}

Future<List<OneLs>> parsedJson(dynamic responseBody) {
  final parsed = responseBody.cast < Map<String, dynamic>();
  return parsed.Map<OneLs>((json) => OneLs.fromJson(json)).toList();
}
