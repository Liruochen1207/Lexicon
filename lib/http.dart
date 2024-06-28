import 'dart:convert';

import 'package:http/http.dart' as http;

Future<List<String>> novelData(int tableIndex, int pageIndex) async {
  var ready = ["error", ""];
  var url = 'http://47.108.91.180:5000/novel?tableIndex=$tableIndex&pageIndex=$pageIndex';
  var response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // 请求成功，处理数据
    Map data = JsonDecoder().convert(response.body);
    if (data['data'][0] == 'ok'){
      ready = ['ok', data['data'][1]];
    }
  } else {
    // 请求失败，打印错误信息
    print('请求失败: ${response.statusCode}');
  }
  return ready;
}
