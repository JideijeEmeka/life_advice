import 'package:flutter/material.dart';
import 'package:life_advice/advice_controller.dart';
import 'package:life_advice/views/home_view.dart';
import 'package:life_advice/views/my_list_view.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoriteView extends StatefulWidget {
  final List favAdviceList;
  const FavoriteView({Key? key, required this.favAdviceList})
      : super(key: key);

  @override
  _FavoriteViewState createState() => _FavoriteViewState();
}

class _FavoriteViewState extends StateMVC<FavoriteView> {
  _FavoriteViewState() : super(AdviceController()) {
    con = controller as AdviceController;
  }
  late AdviceController con;

  @override
  void initState() {
    con.getMyPrefsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        leading: BackButton(onPressed: () =>
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const HomeView())),
            color: Colors.black,),
      ),
      body: SingleChildScrollView(
        child: con.favAdviceList.isEmpty
            ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 250),
              child: Center(
                child: Text('No favorites found...', style: TextStyle(
              color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ) :
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.85,
                child: ListView.builder(
                  itemCount: con.favAdviceList.length,
                    itemBuilder: (context, index) {
                      return MyListView(advice: con.favAdviceList[index],
                        deleteTap: () => con.deleteAdvice(context, index),);
                    }),
              ),
              const SizedBox(height: 40)
            ],
          ),
        ),
      ),
    );
  }
}
