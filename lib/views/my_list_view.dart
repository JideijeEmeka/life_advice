import 'package:flutter/material.dart';
import 'package:life_advice/advice_controller.dart';
import 'package:life_advice/app_text_styles.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class MyListView extends StatefulWidget {
  final String advice;
  final VoidCallback deleteTap;
  const MyListView({Key? key, required this.advice, required this.deleteTap})
      : super(key: key);

  @override
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends StateMVC<MyListView> {
  _MyListViewState() : super(AdviceController()) {
    con = controller as AdviceController;
  }

  late AdviceController con;

  @override
  void initState() {
    con.getPrefs();
    con.getMyPrefsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 15, bottom: 5),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.blue, width: 1.5),
          color: Colors.black87,
          borderRadius: BorderRadius.circular(25)
      ),
      child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(widget.advice,
                    style: AppTextStyles.adviceTextStyle),
              ),
              IconButton(onPressed: widget.deleteTap, icon: const Icon(
                Icons.restore_from_trash,
                color: Colors.white, size: 30)),
            ],
          )
    );
  }
}
