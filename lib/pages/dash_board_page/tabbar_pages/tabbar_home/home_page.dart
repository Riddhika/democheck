import 'package:flutter/material.dart';

import 'home_page_viewmodel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  HomePageViewModel? model;
  @override
  Widget build(BuildContext context) {
    model = HomePageViewModel(state: this);
    return Container(
      color: Colors.pink,
    );
  }
}
