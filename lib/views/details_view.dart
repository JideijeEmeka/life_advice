import 'package:flutter/material.dart';
import 'package:life_advice/advice_controller.dart';
import 'package:life_advice/app_text_styles.dart';
import 'package:life_advice/views/home_view.dart';
import 'package:life_advice/widgets/snack_bar_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

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
                child: Text(con.saved.isEmpty ?
                    'Learn as if you will live forever, live like you '
                        'will die tomorrow' : widget.advice,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.adviceTextStyle
                ),
              ),
            ),
            const Spacer(),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButton(onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const HomeView()));
                },
                color: Colors.white,),
                con.advice.isNotEmpty ?
                Text(widget.id,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.adviceTextStyle
                    )
                : Text('— Mahatma Gandhi', style: AppTextStyles.normalTextStyle(
                    color: Colors.white),),
                /// Add to favorite list
                !con.favAdviceList.contains(con.advice.isNotEmpty ?
                widget.advice : con.saved.isEmpty ? 'Learn as if you will live forever, '
                    'live like you will die tomorrow' : con.saved) ?
                IconButton(onPressed: () async {
                  await con.addAdviceToList(
                      con.advice.isNotEmpty ?
                      widget.advice : con.saved.isEmpty ? 'Learn as if you will live forever,'
                          ' live like you will die tomorrow' : con.saved
                  );
                  con.saveMyPrefsList(con.favAdviceList);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar(
                      message: 'Added to favorites!'));
                },
                    icon: const Icon(Icons.add, color: Colors.white, size: 30,))
                /// Remove from favorite
                    : IconButton(onPressed: () async {
                  con.deleteFavById(context, con.advice.isNotEmpty ?
                  widget.advice : con.saved.isEmpty ? 'Learn as if you will live forever,'
                      ' live like you will die tomorrow' : con.saved);
                },
                    icon: const Icon(Icons.check, color: Colors.white, size: 30,))
            ],)
          ],
        ),
      ));
  }
}
