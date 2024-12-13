import 'package:flutter_test/flutter_test.dart';
import 'package:simuladorprocessos/state.dart';

void main() {
  test('Test AppState singleton', () {
    AppState state = AppState();
    expect(state.turnAroundRR, 0);
  });
}
