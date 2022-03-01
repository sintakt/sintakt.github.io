import 'package:accelerating_metronome/src/click_player/click_player.dart';
import 'package:accelerating_metronome/src/ui_components/pair.dart';
import 'package:accelerating_metronome/src/ui_components/rounded_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';

class ClickView extends StatefulWidget {
  static const routeName = "/play";

  final ClickPlayer player;
  const ClickView(this.player, {Key? key}) : super(key: key);

  @override
  _ClickViewState createState() => _ClickViewState();
}

class _ClickViewState extends State<ClickView> {
  int beat = 0;
  String spent = "0:0";

  @override
  void initState() {
    widget.player.stream.listen((event) {
      setState(() {
        beat = event + 1;
        int seconds = widget.player.totalDuration().inSeconds -
            widget.player.remainingDuration().inSeconds;
        spent = "${seconds ~/ 60}:${seconds % 60}";
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    widget.player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RoundedCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "$beat",
                  style: const TextStyle(fontSize: 100),
                ),
                Pair("Tempo", () => widget.player.bpm.round(), "BPM"),
                Pair("Schritt", () => widget.player.steps + 1,
                    "von ${widget.player.stepAmount}"),
                Pair(
                    "Takt",
                    () =>
                        widget.player.beatAmount ~/
                            widget.player.clicksPerBar %
                            widget.player.barsPerStep +
                        1,
                    "von ${widget.player.barsPerStep}"),
                TextPair(
                  "Zeit",
                  () => spent,
                  "von ${widget.player.totalDuration().inSeconds ~/ 60}:${widget.player.totalDuration().inSeconds % 60} min",
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          ScaleTap(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 60,
              height: 60,
              child: const Icon(Icons.close),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 30,
                        color: Colors.black12,
                        offset: Offset(0, 10)),
                  ]),
            ),
          ),
        ],
      )),
    );
  }
}
