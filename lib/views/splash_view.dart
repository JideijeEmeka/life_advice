import 'dart:async';
import 'package:flutter/material.dart';
import 'package:life_advice/views/home_view.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      pushNewScreen(context, screen: const HomeView());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("la".toUpperCase(), style: GoogleFonts.lato(
        textStyle: const TextStyle(color: Colors.black,
            fontWeight: FontWeight.w500, fontSize: 20)
      ),),
    );
  }
}
