import 'package:flutter/material.dart';
import 'package:simuladorprocessos/state.dart';

class HomePageHeader extends StatefulWidget {
  const HomePageHeader({super.key});

  @override
  State<HomePageHeader> createState() => _HomePageHeaderState();
}

class _HomePageHeaderState extends State<HomePageHeader> {
  AppState appState = AppState();

  TextEditingController quantumController = TextEditingController();
  TextEditingController overloadController = TextEditingController();

  @override
  void initState() {
    super.initState();

    quantumController.text = appState.systemQuantum.toString().padLeft(2, '0');
    overloadController.text =
        appState.systemOverload.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        child: Text('SIMULADOR DE PROCESSOS'),
      ),
    );
  }

  Widget content() {
    return Container(
      height: 70,
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          counter(),
          quantum(),
          overload(),
        ],
      ),
    );
  }

  Widget counter() {
    return Container(
      width: 200,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.black),
      ),
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Número de Processos: '),
          Text(appState.processCounter.toString()),
        ],
      ),
    );
  }

  Widget quantum() {
    return Container(
      width: 200,
      height: 50,
      padding: EdgeInsets.all(5),
      child: TextField(
        controller: quantumController,
        onChanged: (value) {
          appState.updateQuantum(int.tryParse(value) ?? 1);
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          labelStyle: TextStyle(color: Colors.black),
          labelText: 'Quantum do Sistema',
        ),
      ),
    );
  }

  Widget overload() {
    return Container(
      width: 200,
      height: 50,
      padding: EdgeInsets.all(5),
      child: TextField(
        controller: overloadController,
        onChanged: (value) {
          appState.updateOverload(int.parse(value));
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          labelStyle: TextStyle(color: Colors.black),
          labelText: 'Sobrecarga do sistema',
        ),
      ),
    );
  }
}
