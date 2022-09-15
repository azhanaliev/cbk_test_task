import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  Future getData() async {
    http.Response response = await http.get(Uri.parse('https://identification.cbk.kg/api/test_task'));
    print(json.decode(response.body)['holidays']);
    return json.decode(utf8.decode(response.bodyBytes));
  }
}