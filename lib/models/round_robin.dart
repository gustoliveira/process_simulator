import 'package:simuladorprocessos/models/coordinates.dart';
import 'package:simuladorprocessos/models/process.dart';
import 'package:simuladorprocessos/state.dart';
import 'package:simuladorprocessos/utils/extensions.dart';

class RR {
  static Map<String, ProcessTimes> calculate() {
    final AppState appState = AppState();

    final int quantum = appState.systemQuantum;

    Map<String, ProcessTimes> times = {};

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

      List<Process> _availables = []..addAll(
          processes.where((p) => (p.arriveTime! <= time)),
        );
      avaliableProcesses = _availables;

      if (avaliableProcesses.isEmpty) {
        time++;
        continue;
      }

      Process process = avaliableProcesses.first;
      for (int i = 1; i <= quantum; i++) {
        time++;

        avaliableProcesses =
            processes.where((p) => (p.arriveTime! <= time)).toList();

        avaliableProcesses.sort((b, a) {
          var processA = a.deadline ?? 0;
          var processB = b.deadline ?? 0;
          return processB.compareTo(processA);
        });

        times = ProcessTimes.updateTimes(
          avaliableProcesses: avaliableProcesses,
          times: times,
          executing: process,
          time: (time == 1) ? time - 1 : time,
        );

        int remainExecution = (process.executionTime ?? 0) - 1;
        int untilDeadline = (process.deadline ?? 0) - 1;

        process = process.copy(
          executionTime: remainExecution,
          deadline: untilDeadline,
        );

        if (remainExecution == 0) {
          int fromArriveToComplete = time - process.arriveTime!;
          turnaround += fromArriveToComplete;
          avaliableProcesses.removeWhere((p) => p.id == process.id);
          processes.removeWhere((p) => p.id == process.id);
          break;
        }

        if (i != quantum) continue;

        if (remainExecution != 0) {
          times = ProcessTimes.updateTimes(
            avaliableProcesses: avaliableProcesses,
            times: times,
            executing: process,
            time: time,
            isOverloadTime: true,
          );

          time++;

          avaliableProcesses.removeWhere((p) => p.id == process.id);
          processes.replaceWhere(process, (p) => p.id == process.id);
          avaliableProcesses.add(process);
        }
      }
    }

    appState.updateTurnAround(turnAroundRR: turnaround);
    return times;
  }
}
