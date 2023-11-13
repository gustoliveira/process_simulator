import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:simuladorprocessos/models/fifo.dart';
import 'package:simuladorprocessos/models/process_times.dart';
import 'package:simuladorprocessos/state.dart';

class GranttChartPage extends StatefulWidget {
  const GranttChartPage({super.key});

  @override
  State<GranttChartPage> createState() => _GranttChartPageState();
}

class _GranttChartPageState extends State<GranttChartPage> {
  AppState appState = AppState();

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          header(),
          Expanded(child: content()),
        ],
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
            Center(child: Text('FIFO')),
            headerCard(
              'Número de Processos: ${appState.processCounter.toString().padLeft(2, "0")}',
            ),
            headerCard('Turnaround Total: ${appState.turnAroundFIFO}'),
            headerCard('Turnaround Médio: ${appState.averageTurnAroundFIFO}'),
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
      padding: const EdgeInsets.symmetric(horizontal: 10),
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
    var values = Fifo.calculate().values;

    List<Widget> rows = [SizedBox(height: 50)];

    values.forEach((element) {
      rows.add(label(element));
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rows,
    );
  }

  Widget timeIdentifications() {
    List<Widget> rows = [];

    for (int i = 1; i <= 100; i++) {
      rows.add(Container(
        height: 50,
        width: 50,
        child: Center(child: Text(i.toString())),
      ));
    }

    return Row(children: rows);
  }

  Widget label(ProcessTimes processTimes) {
    return Container(
      width: 120,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
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
                  Text('Deadline: ${processTimes.process.deadline}'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget times() {
    var values = Fifo.calculate().values;

    List<Widget> rows = [timeIdentifications()];

    values.forEach((element) {
      rows.add(timesRow(element));
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rows,
    );
  }

  Widget timesRow(ProcessTimes processTimes) {
    return Container(
      child: Row(children: createSquare(processTimes)),
    );
  }

  List<Widget> createSquare(ProcessTimes processTimes) {
    List<Widget> squares = [];

    for (int i = 0; i < 100; i++) {
      if (processTimes.executingTimes.contains(i)) {
        squares.add(square(
          Colors.green,
          (i + 1) == processTimes.deadline,
        ));
        continue;
      }

      if (processTimes.waitingTimes.contains(i)) {
        squares.add(square(
          Colors.yellow,
          (i + 1) == processTimes.deadline,
        ));
        continue;
      }

      if (processTimes.overloadTimes.contains(i)) {
        squares.add(square(
          Colors.red,
          (i + 1) == processTimes.deadline,
        ));
        continue;
      }

      squares.add(square(
        Colors.white,
        (i + 1) == processTimes.deadline,
      ));
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
        child: Center(child: Text('X')),
      ),
    );
  }

  Widget title() {
    return Container(
      height: 70,
      child: Stack(
        children: [
          Center(
            child: Text('SIMULADOR DE PROCESSOS'),
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
          child: Icon(
            Icons.arrow_back,
            size: 25,
          ),
          onTap: () {
            setState(() => print('BACK TO HOME PAGE'));
          },
        ),
      ),
    );
  }
}
