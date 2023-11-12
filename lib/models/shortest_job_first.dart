import 'package:simuladorprocessos/models/process.dart';
import 'package:simuladorprocessos/state.dart';

class SJF {
  static calculate() {
    final AppState appState = AppState();

    Map<String, dynamic> coordinates = {};

    List<Process> processes = []..addAll(appState.process);

    List<Process> avaliableProcesses = [];

    processes.sort((b, a) {
      var processA = a.arriveTime ?? 0;
      var processB = b.arriveTime ?? 0;
      return processB.compareTo(processA);
    });

    int time = 0;
    int turnaround = 0;

    while (true) {
      if (processes.isEmpty) break;

      avaliableProcesses =
          processes.where((p) => (p.arriveTime! <= time)).toList();

      avaliableProcesses.sort((b, a) {
        var processA = a.executionTime ?? 0;
        var processB = b.executionTime ?? 0;
        return processB.compareTo(processA);
      });

      Process process = avaliableProcesses.first;
      while (true) {
        int remainExecution = (process.executionTime ?? 0) - 1;
        process = process.copy(executionTime: remainExecution);

        time++;

        if (remainExecution == 0) {
          int fromArriveToComplete = time - process.arriveTime!;
          turnaround += fromArriveToComplete;

          avaliableProcesses.removeWhere((p) => p.id == process.id);
          processes.removeWhere((p) => p.id == process.id);

          break;
        }
      }

      avaliableProcesses =
          processes.where((p) => !(p.arriveTime! <= time)).toList();
    }

    appState.updateTurnAround(turnAroundSJF: turnaround);

    appState.averageTurnAroundSJF;
    return coordinates;
  }
}
