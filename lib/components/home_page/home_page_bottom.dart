import 'package:flutter/material.dart';
import 'package:simuladorprocessos/models/earliest_deadline_first.dart';
import 'package:simuladorprocessos/models/fifo.dart';
import 'package:simuladorprocessos/models/round_robin.dart';
import 'package:simuladorprocessos/models/shortest_job_first.dart';

class HomePageBottom extends StatefulWidget {
  const HomePageBottom({super.key});

  @override
  State<HomePageBottom> createState() => _HomePageBottomState();
}

class _HomePageBottomState extends State<HomePageBottom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Column(
        children: [
          title(),
          content(),
        ],
      ),
    );
  }

  Widget title() {
    return Expanded(
      child: Center(
        child: Container(
          padding: EdgeInsets.only(top: 10),
          child: Text('ALGORITMOS'),
        ),
      ),
    );
  }

  Widget content() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          escalationButton('FIFO'),
          escalationButton('SJF'),
          escalationButton('EDF'),
          escalationButton('ROUND ROBIN'),
        ],
      ),
    );
  }

  Widget escalationButton(String label) {
    return Center(
      child: Container(
        width: 120,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black),
        ),
        child: InkWell(
          onTap: () {
            Fifo.calculate();
            SJF.calculate();
            EDF.calculate();
            RR.calculate();

            print('Called escalation $label');
          },
          child: Center(child: Text(label)),
        ),
      ),
    );
  }
}
