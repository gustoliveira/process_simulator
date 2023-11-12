import 'package:simuladorprocessos/models/process.dart';

enum ProcessStatus { executing, wait, overload, none }

class Coordinates {
  final int columnId;
  final Map<String, ProcessStatus> values;

  Coordinates(this.columnId, this.values);
}

class ProcessTimes {
  final Process process;

  List<int> waitingTimes = [];
  List<int> overloadTimes = [];
  List<int> executingTimes = [];

  ProcessTimes(this.process);

  void addWaiting(int time) => waitingTimes.add(time);

  void addOverload(int time) => overloadTimes.add(time);

  void addExecuting(int time) => executingTimes.add(time);

  static Map<String, ProcessTimes> updateWaiting({
    required List<Process> avaliableProcesses,
    required Map<String, ProcessTimes> times,
    required Process executing,
    required int time,
  }) {
    Map<String, ProcessTimes> newTimes = {}..addAll(times);

    ProcessTimes? aux = newTimes['${executing.id}'];
    if (aux == null) {
      aux = ProcessTimes(executing);
      aux.addExecuting(time);
      newTimes['${executing.id}'] = aux;
    } else {
      aux.addExecuting(time);
      newTimes['${executing.id}'] = aux;
    }

    avaliableProcesses.forEach((process) {
      if (process.id == executing.id) return;

      var aux = newTimes['${process.id}'];

      if (aux == null) {
        aux = ProcessTimes(process);
        aux.addWaiting(time);
        newTimes['${process.id}'] = aux;
        return;
      }

      aux.addWaiting(time);
      newTimes['${process.id}'] = aux;
    });

    return newTimes;
  }
}
