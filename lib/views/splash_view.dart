import 'dart:async';
import 'package:flutter/material.dart';
import 'package:life_advice/views/home_view.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1500), () {
      pushNewScreen(context, screen: const HomeView());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('asset/images/app_logo.png'),
      ),
    );
  }
}
