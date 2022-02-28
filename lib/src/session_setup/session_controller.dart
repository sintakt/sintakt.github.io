import 'package:accelerating_metronome/src/click_player/click_player.dart';

///This class handles the setup of a metronome session.
///
///Therefore, it saves the values of the PageView pages and provides them for a
///ClickPlayer
class SessionController {
  final Map<String, num> _args = {
    "clicksPerBar": 4,
    "barsPerStep": 8,
    "startBPM": 80,
    "endBPM": 150,
    "stepAmount": 10
  };

  void updateValue(key, value) {
    _args[key] = value;
  }

  num getValue(key) => _args[key] ?? -1;

  int clicksPerBar() => _args["clicksPerBar"]!.toInt();
  int barsPerStep() => _args["barsPerStep"]!.toInt();
  int startBPM() => _args["startBPM"]!.toInt();
  double endBPM() => _args["endBPM"]!.toDouble();
  int stepAmount() => _args["stepAmount"]!.toInt();

  ClickPlayer getPlayer() {
    return ClickPlayer(
      clicksPerBar(),
      barsPerStep(),
      startBPM(),
      (endBPM() - startBPM()) / (stepAmount() - 1),
      stepAmount(),
    );
  }
}
