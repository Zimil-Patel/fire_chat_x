import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiServices{
  ApiServices._();
  static final ApiServices apiServices = ApiServices._();

  final api = "https://api.imgur.com/3/image/";
    final clientId = "954428364df58d9";
  final secretId = "c735c2d607fa1dd1ee44988020f30d01c02e0c8b";
  final authorizationCode = "3a5bf3d7c48efc1408681a6b2aacd8ac01af1e2d";


  Future<String> postImage(Uint8List image) async {
    log("called postImage...");
    final header = {'Authorization': 'Client-ID $clientId'};
    final body = base64Encode(image);
    log("header body set...");
    try{
      log("calling request...");
      final Response response = await http.post(Uri.parse(api) ,headers: header, body: body);
      log(response.statusCode.toString());
      if(response.statusCode == 200){
        log("api request success");
        final data = jsonDecode(response.body);
        return data['data']['link'];
      } else {
        log(response.body);
      }

    } catch(e) {
      log("Api call failed!!!");
    }

    return "https://www.techsmith.com/blog/wp-content/uploads/2023/08/What-are-High-Resolution-Images.png";
  }


  // get access token
  Future<void> getAccessToken(String authCode) async {
    final response = await http.post(
      Uri.parse('https://api.imgur.com/oauth2/token'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: jsonEncode({
        'client_id': clientId,
        'client_secret': secretId,
        'grant_type': authorizationCode,
        'code': authCode,
        'redirect_uri': 'http://localhost',
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      log("Access Token: ${data['access_token']}");
      log("Refresh Token: ${data['refresh_token']}");
    } else {
      log("Error: ${response.body}");
    }
  }
}

