class Process {
  final int id;
  final int? arriveTime;
  final int? executionTime;
  final int? deadline;
  final int? priority;

  const Process(
    this.id, {
    this.arriveTime = 0,
    this.executionTime,
    this.deadline,
    this.priority,
  });

  bool get isNotEmpty => this.executionTime != null && this.arriveTime != null;

  Process copy({
    int? arriveTime,
    int? executionTime,
    int? deadline,
    int? priority,
  }) {
    return Process(
      this.id,
      arriveTime: arriveTime ?? this.arriveTime,
      executionTime: executionTime ?? this.executionTime,
      deadline: deadline ?? this.deadline,
      priority: priority ?? this.priority,
    );
  }

  bool correctProcess() {
    return arriveTime != null &&
        executionTime != null &&
        deadline != null &&
        priority != null;
  }
}
