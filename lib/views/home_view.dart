import 'package:flutter/material.dart';
import 'package:life_advice/app_text_styles.dart';
import 'package:life_advice/advice_controller.dart';
import 'package:life_advice/widgets/drawer_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends StateMVC<HomeView> {
  _HomeViewState() : super(AdviceController()) {
    con = controller as AdviceController;
  }

  late AdviceController con;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      con.getPrefs();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Life Advice'),
        titleTextStyle: const TextStyle(
            fontSize: 17),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
            icon: const Icon(Icons.menu)),
      ),
      drawer: const AppDrawer(),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue,
                  width: 1
                ),
                color: Colors.black,
                borderRadius: BorderRadius.circular(10)
              ),
              child:
                  con.isLoading ? const Center(
                    child: SizedBox(
                      height: 30, width: 30,
                      child: CircularProgressIndicator(
                        color: Colors.blue, backgroundColor: Colors.white,
                      ),
                    ),
                  ) : con.advice.isNotEmpty ?
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text('${con.advice['slip']['advice']}',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.adviceTextStyle
                    ),
                  ) : con.saved.isEmpty ?
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: Text('Learn as if you will live forever, live like you '
                            'will die tomorrow', textAlign: TextAlign.center,
                            style: AppTextStyles.adviceTextStyle),
                      ),
                      Text('— Mahatma Gandhi', style: AppTextStyles.normalTextStyle(
                          color: Colors.white),),
                    ],
                  ) :
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(con.saved, textAlign: TextAlign.center,
                            style: AppTextStyles.adviceTextStyle),
                  ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () async {
              await con.getRandomAdvice();
              con.savePrefs(con.advice['slip']['advice']);
            },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25, vertical: 15),
                  textStyle: AppTextStyles.normalTextStyle(color: Colors.white)
                ),
                child: const Text('Get Advice')),
          ],
        ),
      ),
    );
  }
}
