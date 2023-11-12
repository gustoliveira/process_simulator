extension ListExtensions on List {
  List<dynamic>? replaceWhere(dynamic newElement, bool test(dynamic element)) {
    int _index = -1;

    for (int i = 0; i < this.length; i++) {
      if (test(this[i]) == false) continue;

      _index = i;
      break;
    }

    if (_index == -1) return null;

    this.removeAt(_index);
    this.insert(_index, newElement);

    return this;
  }
}
