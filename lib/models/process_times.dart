import 'package:simuladorprocessos/models/process.dart';

class ProcessTimes {
  final Process process;

  int? deadline;
  List<int> waitingTimes = [];
  List<int> overloadTimes = [];
  List<int> executingTimes = [];

  ProcessTimes(this.process);

  void setDeadline(int time) {
    if (process.deadline == null) return;
    deadline = process.deadline! + time;
  }

  void addWaiting(int time) => waitingTimes.add(time);

  void addOverload(int time) => overloadTimes.add(time);

  void addExecuting(int time) => executingTimes.add(time);

  static Map<String, ProcessTimes> updateTimes({
    required List<Process> avaliableProcesses,
    required Map<String, ProcessTimes> times,
    required Process executing,
    required int time,
    bool isOverloadTime = false,
  }) {
    Map<String, ProcessTimes> newTimes = {}..addAll(times);

    ProcessTimes? aux = newTimes['${executing.id}'];
    if (aux == null) {
      aux = ProcessTimes(executing);
      isOverloadTime ? aux.addOverload(time) : aux.addExecuting(time);
      aux.setDeadline(time);
      newTimes['${executing.id}'] = aux;
    } else {
      isOverloadTime ? aux.addOverload(time) : aux.addExecuting(time);
      newTimes['${executing.id}'] = aux;
    }

    avaliableProcesses.forEach((process) {
      if (process.id == executing.id) return;

      var aux = newTimes['${process.id}'];

      if (aux == null) {
        aux = ProcessTimes(process);
        aux.addWaiting(time);
        aux.setDeadline(time);
        newTimes['${process.id}'] = aux;
        return;
      }

      aux.addWaiting(time);
      newTimes['${process.id}'] = aux;
    });

    return newTimes;
  }
}
