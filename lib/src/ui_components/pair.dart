import 'package:flutter/material.dart';

class Pair extends StatelessWidget {
  const Pair(this.title, this.getData, [this.suffix = "", Key? key])
      : super(key: key);

  final String title;
  final num Function() getData;
  final String suffix;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          ": ${getData().toInt()} $suffix",
          style: Theme.of(context).textTheme.bodyText1,
        )
      ]),
    );
  }
}

class TextPair extends StatelessWidget {
  const TextPair(this.title, this.getData, [this.suffix = "", Key? key])
      : super(key: key);

  final String title;
  final String Function() getData;
  final String suffix;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          ": ${getData()} $suffix",
          style: Theme.of(context).textTheme.bodyText1,
        )
      ]),
    );
  }
}
