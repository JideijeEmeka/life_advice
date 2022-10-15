import 'package:flutter/material.dart';
import 'package:life_advice/advice_controller.dart';
import 'package:life_advice/views/my_list_view.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class FavoriteView extends StatefulWidget {
  final List favList;
  const FavoriteView({Key? key, required this.favList}) : super(key: key);

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
        leading: BackButton(onPressed: () => Navigator.pop(context),
            color: Colors.white,),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          itemCount: con.favList.length,
            itemBuilder: (context, index) {
              return MyListView(id: con.favList[index], advice: '',);
            }),
      ),
    );
  }
}
