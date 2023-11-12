import 'package:simuladorprocessos/models/coordinates.dart';
import 'package:simuladorprocessos/models/process.dart';
import 'package:simuladorprocessos/state.dart';
import 'package:simuladorprocessos/utils/extensions.dart';

class Fifo {
  static Map<int, dynamic> calculate() {
    final AppState appState = AppState();

    Map<int, dynamic> coordinates = {};

    List<Process> processes = []..addAll(appState.process);

    processes.sort((b, a) {
      var processA = a.arriveTime ?? 0;
      var processB = b.arriveTime ?? 0;
      return processB.compareTo(processA);
    });

    int time = 0;
    int turnaround = 0;

    while (true) {
      if (processes.isEmpty) break;

      Process process = processes.first;

      if (!(process.arriveTime! <= time)) {
        time++;
        continue;
      }

      if ((process.executionTime == null || process.executionTime! <= 0)) {
        processes.removeAt(0);
        continue;
      }

      int remainExecution = (process.executionTime ?? 0) - 1;

      processes.replaceWhere(
        process.copy(executionTime: remainExecution),
        (element) => element.id == process.id,
      );

      time++;

      if (remainExecution == 0) {
        int fromArriveToComplete = time - process.arriveTime!;
        turnaround += fromArriveToComplete;
        processes.removeAt(0);
      }

      coordinates[time] = Coordinates(
        time,
        {
          process.id.toString(): ProcessStatus.executing,
        },
      );
    }

    appState.updateTurnAround(turnAroundFIFO: turnaround);
    return coordinates;
  }
}
