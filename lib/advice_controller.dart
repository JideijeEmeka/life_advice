import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:life_advice/constants.dart';
import 'package:life_advice/models/slip.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;

class AdviceController extends ControllerMVC {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late SharedPreferences prefs;
  Map<String, dynamic> advice = {};

  String saved = '';
  bool isLoading = false;
  late String fetchedAdvice;

  Future savePrefs(String fetched) async {
    prefs = await _prefs;
    await prefs.setString('advice', fetched);
  }

  Future getPrefs() async {
    prefs = await _prefs;
    var fetchedAdvice = prefs.getString('advice') ?? '';
    setState(() {
      saved = fetchedAdvice;
    });
    debugPrint(saved);
  }

  Future getRandomAdvice() async {
    setState(() {
      isLoading = true;
    });
      var response = await http.get(randomAdviceUrl);
      if(response.statusCode >= 400) {
        throw ErrorHint('Something Went Wrong!');
      }
      fetchedAdvice = response.body;
      var jsonMap = json.decode(fetchedAdvice);
      debugPrint(fetchedAdvice);
      setState(() {
        advice = jsonMap;
        isLoading = false;
      });
      return Slip.fromJson(jsonMap);
  }

  AdviceController();
}