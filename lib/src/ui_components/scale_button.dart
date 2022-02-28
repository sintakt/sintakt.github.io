import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';

class ScaleButton extends StatelessWidget {
  const ScaleButton(
    this.text, {
    this.onPressed,
    Key? key,
  }) : super(key: key);

  final void Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 60,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                blurRadius: 10, offset: Offset(0, 5), color: Colors.black26),
          ],
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }
}
