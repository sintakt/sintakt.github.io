import 'package:accelerating_metronome/src/session_setup/page_view.dart';
import 'package:accelerating_metronome/src/ui_components/rounded_card.dart';
import 'package:accelerating_metronome/src/ui_components/scale_button.dart';
import 'package:flutter/material.dart';

/// Displays a list of SampleItems.
class MainMenu extends StatelessWidget {
  const MainMenu({
    Key? key,
  }) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        //appBar: AppBar(title: const Text('Sample Items')),
        body: Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          "images/music.jpg",
          fit: BoxFit.cover,
        ),
        Center(
          child: RoundedCard(
            shadowColor: Colors.black45,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Sintakt", style: Theme.of(context).textTheme.headline1),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: w > 500 ? w * 0.5 : w * 0.7,
                  child: Text(
                    "Ein Übungsmetronom, das das Tempo schrittweise erhöht.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText1!,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ScaleButton(
                  "Metronom starten!",
                  onPressed: () => Navigator.restorablePushNamed(
                      context, SetupPages.routeName),
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
