// AppState singleton
import 'package:simuladorprocessos/utils/extensions.dart';

import 'models/process.dart';

class AppState {
  AppState._();
  static final AppState _instance = AppState._();
  static AppState get instance => _instance;
  factory AppState() => _instance;

  int systemOverload = 1;
  int systemQuantum = 1;
  List<Process> process = [];

  int? get _lastProcessId => process.lastOrNull?.id;

  int get processCounter => process.length;

  List<Process> removeProcess(int processId) {
    process.removeWhere((element) => element.id == processId);
    return process;
  }

  List<Process> createProcess({
    int? arriveTime,
    int? executionTime,
    int? deadline,
    int? priority,
  }) {
    int newId = (_lastProcessId ?? 0) + 1;

    process.add(
      Process(
        newId,
        executionTime: executionTime,
        deadline: deadline,
        priority: priority,
      ),
    );

    return process;
  }

  List<Process> updateProcess(
    int id, {
    int? arriveTime,
    int? executionTime,
    int? deadline,
    int? priority,
  }) {
    var updatedProcess = process.firstWhere((element) => element.id == id).copy(
          arriveTime: arriveTime,
          executionTime: executionTime,
          deadline: deadline,
          priority: priority,
        );

    process.replaceWhere(
      updatedProcess,
      (element) => element.id == id,
    );

    return process;
  }

  void updateQuantum(int newQuantum) => systemQuantum = newQuantum;

  void updateOverload(int newOverload) => systemOverload = newOverload;

  List<Process> wrongProcess() {
    List<Process> wrongProcess = [];

    process.forEach((element) {
      if (!(element.correctProcess())) wrongProcess.add(element);
    });

    return wrongProcess;
  }

  bool allChecked() => wrongProcess().isEmpty;
}
