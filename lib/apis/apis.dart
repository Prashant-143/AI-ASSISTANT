import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:ai_assistant/helper/global.dart';
import 'package:http/http.dart';

class APIs {
//Get answer from ChatGPT

  static Future<String> getAnswer(question) async {
    try {
      final response =
          await post(Uri.parse('https://api.openai.com/v1/chat/completions'),
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json',
                HttpHeaders.authorizationHeader: 'Bearer $apiKey'
              },
              body: jsonEncode({
                "model": 'gpt-3.5-turbo',
                "max_tokens": 2000,
                "temperature": 0,
                "messages": [
                  {"role": "user", "content": question},
                ]
              }));
      final data = jsonDecode(response.body);

      log('res: $data');
      return data['choices'][0]['message']['content'];
    } catch (e) {
      log('getAnswerE: $e');
      return "Something went wrong (Please try again in sometime)";
    }
  }

// Background Remover Api

  static Future<Uint8List> removeBG(String imgPath) async {
    var baseUrl = Uri.parse("https://api.remove.bg/v1.0/removebg");
    log('RemoveBG is called');
    log('Image path: $imgPath');
    var req = http.MultipartRequest("POST", baseUrl);

    req.headers.addAll({"X-API-Key": bgRemoverApiKey});

    req.files.add(await http.MultipartFile.fromPath("image_file", imgPath));

    try {
      final res = await req.send();
      log('API request failed with status code: ${res.statusCode}');
      if (res.statusCode == 200) {
        http.Response img = await http.Response.fromStream(res);
        return img.bodyBytes;
      } else {
        return Uint8List(0);
      }
    } catch (e) {
      log('Error during API request: $e');
      return Uint8List(0);
    }
  }
}
