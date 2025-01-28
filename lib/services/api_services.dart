import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiServices{
  ApiServices._();
  static final ApiServices apiServices = ApiServices._();

  final api = "https://api.imgur.com/3/image/";
    final clientId = "bdde645e633548b";
  final secretId = "f7b62d151ff6bb61e1055dc68a37b4aea7014958";

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
}