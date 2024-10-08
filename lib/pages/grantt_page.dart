import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:simuladorprocessos/models/algorithms/algorithms.dart';
import 'package:simuladorprocessos/models/algorithms/earliest_deadline_first.dart';
import 'package:simuladorprocessos/models/algorithms/fifo.dart';
import 'package:simuladorprocessos/models/algorithms/round_robin.dart';
import 'package:simuladorprocessos/models/algorithms/shortest_job_first.dart';
import 'package:simuladorprocessos/models/process_times.dart';
import 'package:simuladorprocessos/state.dart';

class GranttChartPage extends StatefulWidget {
  final Algorithms algorithms;

  const GranttChartPage(this.algorithms, {super.key});

  @override
  State<GranttChartPage> createState() => _GranttChartPageState();
}

class _GranttChartPageState extends State<GranttChartPage> {
  AppState appState = AppState();

  final ScrollController _controller = ScrollController();

  late Map<String, ProcessTimes> calculateCoordinates;
  late String stringTitle;
  late int turnAroundTotal;
  late double turnAroundAverage;

  @override
  void initState() {
    super.initState();

    switch (widget.algorithms) {
      case Algorithms.FIFO:
        calculateCoordinates = Fifo.calculate();
        turnAroundTotal = appState.turnAroundFIFO;
        turnAroundAverage = appState.averageTurnAroundFIFO;
        stringTitle = 'FIRST IN FIRST OUT';
        break;

      case Algorithms.SJF:
        calculateCoordinates = SJF.calculate();
        turnAroundTotal = appState.turnAroundSJF;
        turnAroundAverage = appState.averageTurnAroundSJF;
        stringTitle = 'SHORTEST JOB FIRST';
        break;

      case Algorithms.EDF:
        calculateCoordinates = EDF.calculate();
        turnAroundTotal = appState.turnAroundEDF;
        turnAroundAverage = appState.averageTurnAroundEDF;
        stringTitle = 'EARLIST DEADLINE FIRST';
        break;

      case Algorithms.RR:
        calculateCoordinates = RR.calculate();
        turnAroundTotal = appState.turnAroundRR;
        turnAroundAverage = appState.averageTurnAroundRR;
        stringTitle = 'ROUND ROBIN';
        break;
    }
  }

  @override
  void dispose() {
    calculateCoordinates.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            header(),
            Expanded(child: content()),
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Column(
      children: [
        title(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Text(
                stringTitle,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            headerCard(
              'Número de Processos: ${appState.processCounter.toString().padLeft(2, "0")}',
            ),
            headerCard('Turnaround Total: ${turnAroundTotal}'),
            headerCard('Turnaround Médio: ${turnAroundAverage}'),
          ],
        ),
      ],
    );
  }

  Widget headerCard(String label) {
    return Container(
      width: 200,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.black),
      ),
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Center(
        child: Text(label),
      ),
    );
  }

  Widget content() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Row(
        children: [
          labels(),
          Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.trackpad,
                  PointerDeviceKind.stylus,
                  PointerDeviceKind.unknown,
                },
              ),
              child: Scrollbar(
                controller: _controller,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width,
                    ),
                    child: times(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  labels() {
    List<Widget> rows = [SizedBox(height: 25)];

    calculateCoordinates.values.forEach((element) {
      rows.add(label(element));
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rows,
    );
  }

  Widget timeIdentifications() {
    List<Widget> rows = [];

    for (int i = 0; i <= 100; i++) {
      rows.add(Container(
        height: 20,
        width: 24,
        margin: EdgeInsets.only(right: 26),
        child: Center(child: Text(i.toString())),
      ));
    }

    return Row(children: rows);
  }

  Widget label(ProcessTimes processTimes) {
    return Container(
      width: 120,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 100,
              width: 30,
              child: Center(
                child: Text(
                  processTimes.process.id.toString().padLeft(2, '0'),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Execução: ${processTimes.process.executionTime}'),
                  deadlineLabel(processTimes.process.deadline)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget deadlineLabel(int? deadline) {
    String message = '';
    return Tooltip(
      child: Text('Deadline: $deadline'),
      message: message,
    );
  }

  Widget times() {
    List<Widget> rows = [timeIdentifications()];

    calculateCoordinates.values.forEach((element) {
      rows.add(timesRow(element));
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rows,
    );
  }

  Widget timesRow(ProcessTimes processTimes) {
    return Container(
      padding: EdgeInsets.only(left: 12),
      child: Row(children: createSquare(processTimes)),
    );
  }

  List<Widget> createSquare(ProcessTimes processTimes) {
    List<Widget> squares = [];

    for (int i = 0; i < 100; i++) {
      if (processTimes.executingTimes.contains(i)) {
        squares.add(square(Colors.green, (i + 2) == processTimes.deadline));
        continue;
      }

      if (processTimes.waitingTimes.contains(i)) {
        squares.add(square(Colors.yellow, (i + 2) == processTimes.deadline));
        continue;
      }

      if (processTimes.overloadTimes.contains(i)) {
        squares.add(square(Colors.red, (i + 2) == processTimes.deadline));
        continue;
      }

      squares.add(square(Colors.white, (i + 2) == processTimes.deadline));
    }

    return squares;
  }

  Widget square(Color color, [bool isDeadline = true]) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: color,
      ),
      height: 100,
      width: 50,
      child: Visibility(
        visible: isDeadline,
        child: Tooltip(
          child: Center(child: Text('X')),
          message: 'Deadline deste processo',
        ),
      ),
    );
  }

  Widget title() {
    return Container(
      height: 70,
      child: Stack(
        children: [
          Center(
            child: Text(
              'SIMULADOR DE PROCESSOS',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          backButton(),
        ],
      ),
    );
  }

  Widget backButton() {
    return Container(
      padding: EdgeInsets.only(left: 15),
      child: Align(
        alignment: Alignment.centerLeft,
        child: InkWell(
          child: Icon(Icons.arrow_back, size: 25),
          onTap: () {
            Navigator.pop(context);
            calculateCoordinates.clear();
          },
        ),
      ),
    );
  }
}
