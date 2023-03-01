import 'dart:convert';

import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:http/http.dart' as http;
import '../quizzes/models/quiz.dart';

class QuizzesRepo {
  String baseUrl = Device.get().isAndroid
      ? 'http://192.168.0.80:7001'
      : 'http://localhost:7001';

  Future<TopSelected> getTopSelectedQuiz() async {
    Uri url = Uri.parse('$baseUrl/quizzes/topSelected');

    final response = await http.get(url);

    final data = json.decode(response.body);
    return TopSelected.fromJson(data);
  }

  Future<List<Topic>> getTopicsByCategory(String category) async {
    Uri url = Uri.parse('$baseUrl/quizzes/topics');

    final response = await http.post(url, body: {"category": category});

    final List<dynamic> data = json.decode(response.body);

    List<Topic> list = data.map((e) => Topic.fromJson(e)).toList();

    return list;
  }

  Future<List<Question>> getQuizzesByTopic(String topic) async {
    Uri url = Uri.parse('$baseUrl/quizzes/quiz');

    final response = await http.post(url, body: {"topic": topic});

    final List<dynamic> data = json.decode(response.body);
    List<Question> list = data.map((e) => Question.fromJson(e)).toList();

    return list;
  }
}
