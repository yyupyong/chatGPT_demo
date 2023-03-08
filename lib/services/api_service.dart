import 'dart:convert';
import 'dart:io';

import 'package:chat_app/constansts/api_constants.dart';
import 'package:chat_app/models/chat_model.dart';
import 'package:chat_app/models/models_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(Uri.parse("$BASE_URL/models"),
          headers: {'Authorization': 'Bearer $API_KEY'});

      Map jsonResponse = jsonDecode(response.body);

      //もし間違ったリクエストを送りエラーが帰ってきた場合は以下を返す
      if (jsonResponse["error"] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }
      //成功した場合
      List temp = [];
      for (final value in jsonResponse['data']) {
        temp.add(value);
      }
      return ModelsModel.modelsFromSnapshot(temp);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  static Future<List<ChatModel>> sendMessage(
      {required String message, required String modelId}) async {
    try {
      var response = await http.post(
        Uri.parse("$BASE_URL/completions"),
        headers: {
          'Authorization': 'Bearer $API_KEY',
          "Content-Type": "application/json",
        },
        //postはデータを送信する、欲しいデータを取得する為の型をEncodeしてやる結果として応答が手に入る
        body: jsonEncode(
          {"model": modelId, "prompt": message, "max_tokens": 100},
        ),
      );

      Map jsonResponse = jsonDecode(response.body);

      //もし間違ったリクエストを送りエラーが帰ってきた場合は以下を返す
      //PostManで実際にリクエストを送り、帰ってくるエラープロパティを参照
      if (jsonResponse["error"] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }

      List<ChatModel> chatList = [];
      if (jsonResponse["choices"].length > 0) {
        // log('jsonResponse[choices]text  ${jsonResponse["choices"][0]["text"]}');
        chatList = List.generate(
          jsonResponse["choices"].length,
          (index) => ChatModel(
              msg: jsonResponse["choices"][index]["text"], chatIndex: 1),
        );
      }
      return chatList;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}

// Uri.parse("$BASE_URL/models"),
// headers: {'Authorization: Bearer $API_KEY'},
