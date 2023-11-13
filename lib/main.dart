import 'package:flutter/material.dart';
import 'package:simuladorprocessos/pages/grantt_page.dart';
import 'package:simuladorprocessos/pages/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: GranttChartPage(),
        // body: HomePage(),
      ),
    );
  }
}
