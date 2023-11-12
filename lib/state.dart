import 'package:simuladorprocessos/utils/extensions.dart';

import 'models/process.dart';

class AppState {
  AppState._();
  static final AppState _instance = AppState._();
  static AppState get instance => _instance;
  factory AppState() => _instance;

  int systemOverload = 1;
  int systemQuantum = 2;
  List<Process> process = [
    Process(
      1,
      arriveTime: 0,
      executionTime: 4,
      deadline: 7,
    ),
    Process(
      2,
      arriveTime: 2,
      executionTime: 2,
      deadline: 5,
    ),
    Process(
      3,
      arriveTime: 4,
      executionTime: 1,
      deadline: 8,
    ),
    Process(
      4,
      arriveTime: 6,
      executionTime: 3,
      deadline: 10,
    ),
  ];

  int turnAroundFIFO = 0;
  int turnAroundSJF = 0;
  int turnAroundEDF = 0;
  int turnAroundRR = 0;

  int? get _lastProcessId => process.lastOrNull?.id;

  int get processCounter => process.length;

  double get averageTurnAroundFIFO => turnAroundFIFO / (process.length);
  double get averageTurnAroundSJF => turnAroundSJF / (process.length);
  double get averageTurnAroundEDF => turnAroundEDF / (process.length);
  double get averageTurnAroundRR => turnAroundRR / (process.length);

  void updateTurnAround({
    int? turnAroundFIFO,
    int? turnAroundSJF,
    int? turnAroundEDF,
    int? turnAroundRR,
  }) {
    this.turnAroundFIFO = turnAroundFIFO ?? this.turnAroundFIFO;
    this.turnAroundSJF = turnAroundSJF ?? this.turnAroundSJF;
    this.turnAroundEDF = turnAroundEDF ?? this.turnAroundEDF;
    this.turnAroundRR = turnAroundRR ?? this.turnAroundRR;
  }

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
