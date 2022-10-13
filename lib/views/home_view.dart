import 'package:flutter/material.dart';
import 'package:life_advice/app_text_styles.dart';
import 'package:life_advice/widgets/drawer_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
              height: 170,
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
              child: Column(
                children: [
                  Text('Learn as if you will live forever, live like you will '
                      'die tomorrow.', textAlign: TextAlign.center,
                      style: AppTextStyles.adviceTextStyle),
                  Padding(
                    padding: const EdgeInsets.only(top: 13),
                    child: Text('— Mahatma Gandhi', style: AppTextStyles.normalTextStyle(
                        color: Colors.white),),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25, vertical: 15),
                  textStyle: AppTextStyles.normalTextStyle(color: Colors.white)
                ),
                child: const Text('Get Advice'))
          ],
        ),
      ),
    );
  }
}
