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
  String savedId = '';
  bool isLoading = false;
  List<String> favList = [];
  late String fetchedAdvice;

  Future savePrefs(String fetched, String fetchedId) async {
    prefs = await _prefs;
    await prefs.setString('advice', fetched);
    await prefs.setString('id', fetchedId);
  }

  Future getPrefs() async {
    prefs = await _prefs;
    var fetchedAdvice = prefs.getString('advice') ?? '';
    var fetchedId = prefs.getString('id') ?? '';
    setState(() {
      saved = fetchedAdvice;
      savedId = fetchedId;
    });
    debugPrint(saved);
  }

  Future saveMyPrefsList(List<String> list) async {
    prefs = await _prefs;
    prefs.setStringList('savedList', list);
  }

  Future getMyPrefsList() async {
    prefs = await _prefs;
    // prefs.clear();
    var fetchedAdviceList = prefs.getStringList('savedList') ?? [];
    setState(() {
      favList = fetchedAdviceList;
    });
    debugPrint('see list: $favList');
  }

  Future addAdviceToList(String id, String advice) async {
    favList.insert(0, id);
    favList.insert(0, advice);
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