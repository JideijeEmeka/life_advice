import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:life_advice/app_text_styles.dart';
import 'package:life_advice/constants.dart';
import 'package:life_advice/models/slip.dart';
import 'package:life_advice/widgets/snack_bar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class AdviceController extends ControllerMVC {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late SharedPreferences prefs;
  Map<String, dynamic> advice = {};

  // Fetch Random Advice
  String saved = '';
  String savedId = '';
  bool isLoading = false;
  late String fetchedAdvice;

  // Add advice to Favorite List
  List<String> favIdList = [];
  List<String> favAdviceList = [];
  List<String> myList = [];

  // Check Internet Connection
  bool isConnected = false;
  ConnectivityResult connectivityResult = ConnectivityResult.none;

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
    var fetchedAdviceList = prefs.getStringList('savedList') ?? [];
    setState(() {
      favIdList = fetchedAdviceList;
      favAdviceList = fetchedAdviceList;
      myList = fetchedAdviceList;
    });
    debugPrint('see list: $favAdviceList');
  }

  Future addAdviceToList(String advice) async {
    favAdviceList.insert(0, advice);
    notifyListeners();
  }

  void deleteAdvice(BuildContext context, int index) {
    favAdviceList.removeAt(index);
    saveMyPrefsList(favAdviceList);
    ScaffoldMessenger.of(context).showSnackBar(snackBar(message:
        'deleted successfully!'));
    notifyListeners();
  }

  void deleteFavById(BuildContext context, String advice) {
    favAdviceList.remove(advice);
    saveMyPrefsList(favAdviceList);
    ScaffoldMessenger.of(context).showSnackBar(snackBar(message:
    'Removed from favorites Movies!!!'));
    notifyListeners();
  }

  Future getRandomAdvice() async {
    setState(() {
      isLoading = true;
    });
      final connected = await checkInternet();
      final color = isConnected ? Colors.green : Colors.red;
      if(!connected) {
        showSimpleNotification(
          Text('You are offline...', style: AppTextStyles.normalTextStyle(color: Colors.white)),
          background: color,
        );
        setState(() {
          isLoading = false;
        });
      }
      var response = await http.get(randomAdviceUrl);
      if(response.statusCode >= 400) {
        throw ErrorHint('Bad request!');
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

  Future<bool> checkInternet() async {
    isConnected = await InternetConnectionChecker().hasConnection;
    return isConnected;
  }

  AdviceController();
}