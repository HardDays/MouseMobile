import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;

class VkAPI {

  static String codeUrl = 'https://oauth.vk.com/authorize?client_id=6326995&client_secret=bK8i6pmtQikvBLMEYH55';
  static String tokenUrl = 'https://oauth.vk.com/access_token?client_id=6326995&client_secret=bK8i6pmtQikvBLMEYH55'; 

  static Future<String> getAccessToken(String codeUrl) async {
    var codePos = codeUrl.indexOf('code=');
    var code = codeUrl.substring(codePos + 5);

    var res = await http.get(tokenUrl + '&code=$code');
    if (res.statusCode == HttpStatus.ok){
      return json.decode(res.body)['access_token'];
    }
  }
}