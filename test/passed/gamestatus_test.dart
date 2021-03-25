import 'package:flutter_test/flutter_test.dart';
import 'package:tetris/entities/gamestatus.dart';

void main() {
  test('GameStatus can be constructed and read', () {
    const notStarted = GameStatus.notStarted;
    const running = GameStatus.running;
    const lost = GameStatus.lost;
    const won = GameStatus.won;
    const paused = GameStatus.paused;
    expect(notStarted is GameStatus, true);
    expect(running is GameStatus, true);
    expect(lost is GameStatus, true);
    expect(won is GameStatus, true);
    expect(paused is GameStatus, true);
  });
}
