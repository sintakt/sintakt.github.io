import 'package:flutter/material.dart';

class RoundedCard extends StatelessWidget {
  const RoundedCard({this.shadowColor, this.child, Key? key}) : super(key: key);

  final Widget? child;
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                  blurRadius: 30,
                  color: shadowColor ?? Colors.black12,
                  offset: const Offset(0, 10)),
            ]),
        child: child);
  }
}
