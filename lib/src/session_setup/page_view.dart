import 'package:accelerating_metronome/src/click_player/click_view.dart';
import 'package:accelerating_metronome/src/ui_components/pair.dart';
import 'package:accelerating_metronome/src/ui_components/scale_button.dart';
import 'package:flutter/material.dart';

import '../ui_components/rounded_card.dart';
import 'session_controller.dart';
import 'knop_page.dart';

class SetupPages extends StatefulWidget {
  const SetupPages({Key? key}) : super(key: key);

  static const routeName = '/setup';

  @override
  _SetupPagesState createState() => _SetupPagesState();
}

class _SetupPagesState extends State<SetupPages> {
  final _sessionController = SessionController();
  final PageController _pageController = PageController();

  void _nextPage() {
    _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutQuad);
  }

  void _prevPage() {
    _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutQuad);
  }

  @override
  Widget build(BuildContext context) {
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Neue Übungsphase"),
      ),
      body: Row(
        children: [
          IconButton(onPressed: _prevPage, icon: const Icon(Icons.arrow_back)),
          Expanded(
            child: PageView(
              clipBehavior: Clip.none,
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: [
                SetupKnobPage(
                  () => _sessionController.getValue("startBPM"),
                  (val) => _sessionController.updateValue("startBPM", val),
                  "Starttempo",
                  _nextPage,
                  sensitivity: 0.7,
                ),
                SetupKnobPage(
                  () => _sessionController.getValue("endBPM"),
                  (val) => _sessionController.updateValue("endBPM", val),
                  "Endtempo",
                  _nextPage,
                  sensitivity: 0.7,
                ),
                SetupKnobPage(
                  () => _sessionController.getValue("stepAmount"),
                  (val) => _sessionController.updateValue("stepAmount", val),
                  "Anzahl Schritte",
                  _nextPage,
                  suffix: "SCHRITTE",
                  sensitivity: .2,
                ),
                SetupKnobPage(
                  () => _sessionController.getValue("barsPerStep"),
                  (val) => _sessionController.updateValue("barsPerStep", val),
                  "Takte pro Schritt",
                  _nextPage,
                  suffix: "TAKTE",
                  sensitivity: .1,
                ),
                SetupKnobPage(
                  () => _sessionController.getValue("clicksPerBar"),
                  (val) => _sessionController.updateValue("clicksPerBar", val),
                  "Schläge pro Takt",
                  _nextPage,
                  suffix: "SCHLÄGE",
                  sensitivity: .05,
                ),
                Center(
                  child: RoundedCard(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Pair(
                            "Starttempo",
                            () => _sessionController.getValue("startBPM"),
                            "BPM"),
                        Pair("Endtempo",
                            () => _sessionController.getValue("endBPM"), "BPM"),
                        Pair(
                            "Anzahl Schritte",
                            () => _sessionController.getValue("stepAmount"),
                            "Schritte"),
                        Pair(
                            "Takte pro Schritt",
                            () => _sessionController.getValue("barsPerStep"),
                            "Takte"),
                        Pair(
                            "Schläge pro Takt",
                            () => _sessionController.getValue("clicksPerBar"),
                            "Schläge"),
                        TextPair(
                          "Dauer",
                          () {
                            int seconds = _sessionController
                                .getPlayer()
                                .totalDuration()
                                .inSeconds;
                            return "${seconds ~/ 60}:${seconds % 60}";
                          },
                          "min",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ScaleButton(
                          "Starten!",
                          onPressed: () => Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                            return ClickView(_sessionController.getPlayer());
                          })),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          IconButton(
              onPressed: _nextPage, icon: const Icon(Icons.arrow_forward)),
        ],
      ),
    );
  }
}

class SetupKnobPage extends StatefulWidget {
  const SetupKnobPage(this.getVal, this.setVal, this.title, this.nextPage,
      {this.sensitivity = 1, this.suffix = "BPM", Key? key})
      : super(key: key);

  final String title;
  final String suffix;
  final double sensitivity;
  final void Function() nextPage;
  final void Function(num) setVal;
  final num Function() getVal;

  @override
  State<SetupKnobPage> createState() => _SetupKnobPageState();
}

class _SetupKnobPageState extends State<SetupKnobPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: KnobPage(
        widget.title,
        () {
          return widget.getVal();
        },
        onDragEnd: widget.nextPage,
        onChange: (newVal) {
          widget.setVal(newVal);
        },
        sensitivity: widget.sensitivity,
        suffix: widget.suffix,
      ),
    );
  }
}
