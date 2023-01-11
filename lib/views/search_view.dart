import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:life_advice/advice_controller.dart';
import 'package:life_advice/app_text_styles.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchView extends StatefulWidget {
  final int drawerIndex;
  const SearchView({Key? key,
    required this.drawerIndex}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends StateMVC<SearchView> {
  _SearchViewState() : super(AdviceController()) {
    con = controller as AdviceController;
  }
  late AdviceController con;
  bool typing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: con.scaffoldKey,
      backgroundColor: Colors.black,
      appBar: PreferredSize(child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        elevation: 0.0,
        leading: BackButton(onPressed: () =>
            Navigator.pop(context),
          color: Colors.white,),
        bottom: PreferredSize(child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey.withOpacity(0.25),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.search, color: Colors.white.withOpacity(0.7), size: 28),
                const SizedBox(width: 15,),
                Expanded(
                  child: TextField(
                    controller: con.searchController,
                    style: AppTextStyles.titleTextStyle,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    cursorHeight: 29,
                    cursorColor: Colors.white,
                    onChanged: (String val) {
                      setState(() {
                        if(val.isEmpty) {
                          typing = false;
                        }else {
                          typing = true;
                        }
                        con.searchAdvice(query: val);
                      });
                    },
                    onSubmitted: (String val) {
                      if(val.isEmpty) {
                        FocusManager.instance.primaryFocus?.requestFocus();
                      }
                    },
                    decoration: InputDecoration.collapsed(
                      hintText: 'Search for a motivation, an advice etc.',
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.7),
                          fontSize: 16),
                    ),),
                ),
                typing ?
                IconButton(onPressed: () async {
                  con.searchController.clear();
                  setState(() {
                    typing = false;
                  });
                },
                    icon: FaIcon(FontAwesomeIcons.xmark,
                      color: Colors.white.withOpacity(0.7)))
                    : Container()
              ],),
          ),
        ), preferredSize: const Size.fromHeight(0)),
      ),
          preferredSize: const Size.fromHeight(120)),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text('Top Searches', style: AppTextStyles.bigTextStyle,),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 50),
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: con.searchedAdviceList.length,
                        itemBuilder: (context, i) {
                          return Container(
                            height: 110,
                            color: Colors.grey.withOpacity(0.25),
                            padding: const EdgeInsets.only(right: 15),
                            margin: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              children: [
                                SizedBox(
                                    height: 110,
                                    width: 100,
                                    child: ClipRRect(child: Image.asset('asset/images/search_logo.png', fit: BoxFit.fill,))),
                                Container(
                                  width: 295,
                                  padding: const EdgeInsets.only(top: 5, bottom: 5, left: 8),
                                  child: Text(con.searchedAdviceList[i]['advice'],
                                    style: AppTextStyles.normalTextStyle(
                                        color: Colors.white.withOpacity(0.7)),),
                                ),
                              ],
                            ),
                          );
                    }),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text("Total Searched Results: ${con.totalSearchedResults}",
                        style: AppTextStyles.normalTextStyle(
                            color: Colors.white),),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
