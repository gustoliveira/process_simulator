enum ProcessStatus { executing, wait, overload, none }

class Coordinates {
  final int columnId;
  final Map<String, ProcessStatus> values;

  Coordinates(this.columnId, this.values);
}
