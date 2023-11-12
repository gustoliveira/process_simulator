import 'package:simuladorprocessos/models/coordinates.dart';

class Process {
  final int id;
  final int? arriveTime;
  final int? executionTime;
  final int? deadline;
  final int? priority;
  final ProcessStatus? status;

  const Process(
    this.id, {
    this.arriveTime = 0,
    this.executionTime,
    this.deadline,
    this.priority,
    this.status = ProcessStatus.none,
  });

  Process copy({
    int? arriveTime,
    int? executionTime,
    int? deadline,
    int? priority,
    ProcessStatus? status,
  }) {
    return Process(
      this.id,
      arriveTime: arriveTime ?? this.arriveTime,
      executionTime: executionTime ?? this.executionTime,
      deadline: deadline ?? this.deadline,
      priority: priority ?? this.priority,
      status: status ?? this.status,
    );
  }

  bool correctProcess() {
    return arriveTime != null &&
        executionTime != null &&
        deadline != null &&
        priority != null;
  }
}
