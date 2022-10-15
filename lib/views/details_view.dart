import 'package:flutter/material.dart';
import 'package:life_advice/advice_controller.dart';
import 'package:life_advice/app_text_styles.dart';
import 'package:life_advice/constants.dart';
import 'package:life_advice/views/home_view.dart';
import 'package:life_advice/widgets/snack_bar_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:http/http.dart' as http;

class DetailsView extends StatefulWidget {
  final String id, advice;
  const DetailsView({Key? key, required this.advice, required this.id}) : super(key: key);

  @override
  _DetailsViewState createState() => _DetailsViewState();
}

class _DetailsViewState extends StateMVC<DetailsView> {
  _DetailsViewState() : super(AdviceController()) {
    con = controller as AdviceController;
  }
  late AdviceController con;

  // Future getAdviceDetails(String id) async {
  //   var response = await http.get(adviceDetailsUrl(id: id));
  //   if(response.statusCode >= 400) {
  //     throw ErrorHint('Something Went Wrong!');
  //   }
  //   debugPrint(response.body);
  // }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      con.getPrefs();
      con.getMyPrefsList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2.5),
        color: Colors.black, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Center(
                child: Text(widget.advice,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.adviceTextStyle
                ),
              ),
            ),
            Spacer(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButton(onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const HomeView()));
                },
                color: Colors.white,),
                Text(widget.id,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.adviceTextStyle
                    ),
                IconButton(onPressed: () async {
                  await con.addAdviceToList(widget.id, widget.advice);
                  con.saveMyPrefsList(con.favList);
                  print('${con.favList}');
                  ScaffoldMessenger.of(context).showSnackBar(snackBar(
                      message: 'Added to favorites!'));
                },
                    icon: const Icon(Icons.add, color: Colors.white, size: 30,))
            ],)
          ],
        ),
      ));
  }
}
