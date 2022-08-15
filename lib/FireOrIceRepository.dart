import 'dart:convert';

import 'package:fire_and_ice/FireOrIceModel.dart';
import 'package:http/http.dart' as http;

abstract class IFireOrIceRepository {
  getLatestFireOrIce();
}

class FireOrIceRepository extends IFireOrIceRepository {
  @override
  Future<FireOrIceModel> getLatestFireOrIce() async {
    var url = Uri.parse('https://mabrook.herokuapp.com/api/fireandice');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${utf8.decode(response.bodyBytes)}');

    dynamic rawData = json.decode(utf8.decode(response.bodyBytes));

    return FireOrIceModel.fromJson(rawData);
  }

  Future<void> updateFireOrIce(FireOrIceModel fireOrIceModel) async {
    var url = Uri.parse('https://mabrook.herokuapp.com/api/fireandice');
    var response = await http.post(url,
        body: json.encode(fireOrIceModel),
        headers: {'Content-Type': 'application/json'});
    print('Request body: ${fireOrIceModel.toJson()}');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return null;
  }
}
