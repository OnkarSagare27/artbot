import 'dart:developer';
import 'dart:typed_data';
// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeScreenProvider extends ChangeNotifier {
  TextEditingController promtEditingController = TextEditingController();
  TextEditingController apiKeyEditingController = TextEditingController();

  HomeScreenProvider() {
    toggleLoading();
    getApiKeyFromSP();
    toggleLoading();
  }

  bool isLoading = false;

  String? apiKey;

  Future<void> getApiKeyFromSP() async {
    SharedPreferences preffs = await SharedPreferences.getInstance();
    apiKey = preffs.getString('apiKey') ??
        'vk-M3hbHUSuMmDBJ2FDGB55uQPGeOW2qtMgnk9MNlHsMSJpRt';

    apiKeyEditingController.text = apiKey!;
    notifyListeners();
  }

  Future<void> saveApiKey(String newApiKey) async {
    SharedPreferences preffs = await SharedPreferences.getInstance();
    preffs.setString('apiKey', newApiKey);
    apiKey = newApiKey;

    notifyListeners();
  }

  Future<void> saveToHistory(String prompt) async {
    SharedPreferences preff = await SharedPreferences.getInstance();
    List<String> history = preff.getStringList('history') ?? [];
    history.add(prompt);
    preff.setStringList('history', history);
  }

  void toggleLoading() {
    isLoading = !isLoading;
    notifyListeners();
  }

//   Future<Uint8List?> generate(String prompt) async {
//     try {
//       log('Started');

//       String url = 'https://api.vyro.ai/v1/imagine/api/generations';
//       Map<String, dynamic> headers = {'Authorization': 'Bearer $apiKey}'};

//       Map<String, dynamic> payload = {
//         'prompt': prompt,
//         'style_id': '29',
//         'aspect_ratio': '1:1',
//         'high_res_results': '1'
//       };

//       FormData formData = FormData.fromMap(payload);

//       Dio dio = Dio();
//       dio.options =
//           BaseOptions(headers: headers, responseType: ResponseType.bytes);

//       final response = await dio.post(url, data: formData);
//       if (response.statusCode == 200) {
//         // log(response.data.runtimeType.toString());
//         // log(response.data.toString());
//         Uint8List uint8List = Uint8List.fromList(response.data);
//         log('Hi finished');
//         return uint8List;
//       } else {
//         log('Hi finished 2');
//         return null;
//       }
//     } catch (e) {
//       log(e.toString());
//     }
//     return null;
//   }

  Future<Uint8List?> generate(String prompt) async {
    try {
      String url = 'https://api.vyro.ai/v1/imagine/api/generations';
      Map<String, String> headers = {
        'Authorization': 'Bearer $apiKey',
      };

      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.headers.addAll(headers);

      request.fields['prompt'] = prompt;
      request.fields['style_id'] = '29';
      request.fields['aspect_ratio'] = '1:1';
      request.fields['high_res_results'] = '1';

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBytes = await response.stream.toBytes();
        return Uint8List.fromList(responseBytes);
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
