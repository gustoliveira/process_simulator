import 'package:flutter/material.dart';
import 'package:simuladorprocessos/models/process.dart';
import 'package:simuladorprocessos/state.dart';

class ProcessCard extends StatefulWidget {
  final Process process;
  final Function(int) removeProcessCallback;

  const ProcessCard(
    this.process, {
    required this.removeProcessCallback,
    super.key,
  });

  @override
  State<ProcessCard> createState() => _ProcessCardState();
}

class _ProcessCardState extends State<ProcessCard> {
  AppState appState = AppState();

  String get processId => widget.process.id.toString().padLeft(2, '0');

  TextEditingController arriveTimeController = TextEditingController();
  TextEditingController executionTimeController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();
  TextEditingController priorityController = TextEditingController();

  @override
  void initState() {
    super.initState();

    arriveTimeController.text = (widget.process.arriveTime ?? '').toString();
    executionTimeController.text =
        (widget.process.executionTime ?? '').toString();
    deadlineController.text = (widget.process.deadline ?? '').toString();
    priorityController.text = (widget.process.priority ?? '').toString();
  }

  void updateProcessData() {
    appState.updateProcess(
      widget.process.id,
      arriveTime: int.tryParse(arriveTimeController.text),
      executionTime: int.tryParse(executionTimeController.text),
      deadline: int.tryParse(deadlineController.text),
      priority: int.tryParse(priorityController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 222,
      height: 262,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          header(),
          field('Tempo de chegada', arriveTimeController),
          field('Tempo de execução', executionTimeController),
          field('Deadline', deadlineController),
          field('Prioridade', priorityController),
        ],
      ),
    );
  }

  Widget header() {
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Processo $processId'),
          iconButton(),
        ],
      ),
    );
  }

  Widget iconButton() {
    return InkWell(
      child: Icon(Icons.delete),
      onTap: () {
        setState(() {
          widget.removeProcessCallback.call(widget.process.id);
          print(
              "Process '${widget.process.id.toString().padLeft(2, '0')}' deleted");
        });
      },
    );
  }

  Widget field(
    String label,
    TextEditingController controller,
  ) {
    return Theme(
      data: new ThemeData(
        primaryColor: Colors.redAccent,
        primaryColorDark: Colors.red,
      ),
      child: Container(
        width: 200,
        height: 50,
        padding: EdgeInsets.all(5),
        child: TextField(
          controller: controller,
          onChanged: (value) => updateProcessData(),
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
            labelText: label,
          ),
        ),
      ),
    );
  }
}
