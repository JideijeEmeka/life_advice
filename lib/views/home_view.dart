import 'package:flutter/material.dart';
import 'package:life_advice/app_text_styles.dart';
import 'package:life_advice/advice_controller.dart';
import 'package:life_advice/views/details_view.dart';
import 'package:life_advice/widgets/drawer_widget.dart';
import 'package:life_advice/widgets/snack_bar_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:google_fonts/google_fonts.dart';

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
      key: con.scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: const Text('Get Advice'),
        titleTextStyle: GoogleFonts.lobster(
          textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18,
            letterSpacing: 1.5, color: Colors.black)
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            con.scaffoldKey.currentState!.openDrawer();
          },
            icon: const Icon(Icons.menu, color: Colors.black,)),
        actions: [
          /// Add to favorite list
          !con.favAdviceList.contains(con.advice.isNotEmpty ?
          con.advice['slip']['advice'] : con.saved.isEmpty ? 'Learn as if you will live forever, '
              'live like you will die tomorrow' : con.saved) ?
          IconButton(onPressed: () async {
            await con.addAdviceToList(
                con.advice.isNotEmpty ?
                con.advice['slip']['advice'] : con.saved.isEmpty ? 'Learn as if you will live forever, '
                    'live like you will die tomorrow' : con.saved
            );
            con.saveMyPrefsList(con.favAdviceList);
            debugPrint('see latest advice list: ${con.favAdviceList}');
            ScaffoldMessenger.of(context).showSnackBar(snackBar(
                message: 'Added to favorites!'));
          },
              icon: const Icon(Icons.add, color: Colors.black, size: 30,))
          /// Remove from favorite
          : IconButton(onPressed: () async {
            con.deleteFavById(context, con.advice.isNotEmpty ?
            con.advice['slip']['advice'] : con.saved.isEmpty ? 'Learn as if you will live forever, '
                'live like you will die tomorrow' : con.saved);
            debugPrint('see latest advice list: ${con.favAdviceList}');
          },
              icon: const Icon(Icons.check, color: Colors.black, size: 30,))
        ],
      ),
      drawer: const AppDrawer(),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            InkWell(
              onTap: () =>
              {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => DetailsView(
                              advice: con.advice.isNotEmpty ?
                                con.advice['slip']['advice'] : con.saved,
                              id: con.advice.isNotEmpty ?
                                con.advice['slip']['id'].toString() : con.savedId,
                            )))
              },
              child: Container(
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
            ),
            const SizedBox(height: 30),
            ElevatedButton(onPressed: () async {
              await con.getRandomAdvice();
              con.savePrefs(con.advice['slip']['advice'],
                  con.advice['slip']['id'].toString());
            },
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  primary: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25, vertical: 15),
                  textStyle: AppTextStyles.normalTextStyle(color: Colors.white)
                ),
                child: const Text('Advice me')),
          ],
        ),
      ),
    );
  }
}
