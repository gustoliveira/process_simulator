import 'package:flutter/material.dart';
import 'package:simuladorprocessos/components/create_process_card.dart';
import 'package:simuladorprocessos/components/home_page/home_page_bottom.dart';
import 'package:simuladorprocessos/components/home_page/home_page_header.dart';
import 'package:simuladorprocessos/components/process_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          HomePageHeader(),
          body(),
          HomePageBottom(),
        ],
      ),
    );
  }

  Widget body() {
    return Expanded(
      child: Container(
        color: Colors.green,
        child: Row(
          children: [
            ProcessCard(),
            CreatePorcessCard(),
          ],
        ),
      ),
    );
  }
}
