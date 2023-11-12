// AppState singleton
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

  List<Process> addProcess(Process newProcess) {
    process.add(newProcess);
    return process;
  }

  List<Process> removeProcess(Process newProcess) {
    process.remove(newProcess);
    return process;
  }

  List<Process> createProcess({
    int? arriveTime,
    int? executionTime,
    int? deadline,
    int? priority,
  }) {
    int newId = (_lastProcessId ?? 0) + 1;

    process.remove(
      Process(
        newId,
        arriveTime: arriveTime,
        executionTime: executionTime,
        deadline: deadline,
        priority: priority,
      ),
    );

    return process;
  }
}
