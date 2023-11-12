class Process {
  int id;

  int? arriveTime;
  int? executionTime;
  int? deadline;
  int? priority;

  Process(
    this.id, {
    this.arriveTime = 0,
    this.executionTime,
    this.deadline,
    this.priority,
  });
}
