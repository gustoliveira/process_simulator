import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:simuladorprocessos/components/create_process_card.dart';
import 'package:simuladorprocessos/components/home_page/home_page_bottom.dart';
import 'package:simuladorprocessos/components/home_page/home_page_header.dart';
import 'package:simuladorprocessos/components/process_card.dart';
import 'package:simuladorprocessos/state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AppState appState = AppState();

  final ScrollController _controller = ScrollController();

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
        padding: EdgeInsets.only(right: 10),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CreatePorcessCard(
                        createProcessCallback: createProcessCallback),
                    ...processList(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void createProcessCallback() {
    setState(() => appState.createProcess());
  }

  void removeProcessCallback(int processId) {
    setState(() => appState.removeProcess(processId));
  }

  List<Widget> processList() {
    List<Widget> processes = [];

    appState.process.forEach((process) {
      processes.add(ProcessCard(
        process,
        removeProcessCallback: removeProcessCallback,
      ));
    });

    return processes;
  }
}
