import 'package:flutter/material.dart';
import 'package:life_advice/advice_controller.dart';
import 'package:life_advice/views/home_view.dart';
import 'package:life_advice/views/my_list_view.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

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
        title: const Text('Life Advice'),
        titleTextStyle: const TextStyle(
            fontSize: 17),
        centerTitle: true,
        leading: BackButton(onPressed: () =>
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const HomeView())),
            color: Colors.white,),
      ),
      body: SingleChildScrollView(
        child: con.favAdviceList.isEmpty
            ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 250),
              child: Center(
                child: Text('No favorites found...', style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold)),
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
