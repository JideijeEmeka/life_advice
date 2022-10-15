import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:life_advice/constants.dart';
import 'package:http/http.dart' as http;
import 'package:life_advice/models/slip.dart';

class MyListView extends StatefulWidget {
  final String id, advice;
  const MyListView({Key? key, required this.id, required this.advice}) : super(key: key);

  @override
  State<MyListView> createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  Map<String, dynamic> details = {};

  Future getAdviceDetails() async {
    var response = await http.get(adviceDetailsUrl(id: widget.id));
    if(response.statusCode >= 400) {
      throw ErrorHint('Something Went Wrong!');
    }
    debugPrint(response.body);
    setState(() {
      details = jsonDecode(response.body);
    });
    return Slip.fromJson(details);
  }

  @override
  void initState() {
    getAdviceDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(widget.id,
      style: TextStyle(color: Colors.black),);
  }
}
