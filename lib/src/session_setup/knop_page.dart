import 'dart:math';

import 'package:flutter/material.dart';
import 'knob_widget/knob_widget.dart';
import 'knob_widget/controller/knob_controller.dart';
import 'knob_widget/utils/control_style.dart';
import 'knob_widget/utils/control_tick_style.dart';
import 'knob_widget/utils/knob_style.dart';
import 'knob_widget/utils/major_tick_style.dart';
import 'knob_widget/utils/minor_tick_style.dart';
import 'knob_widget/utils/pointer_style.dart';
import '../ui_components/rounded_card.dart';

///A Knob that can be used to set a number
class KnobPage extends StatefulWidget {
  final String text;
  final num Function() initialValue;
  final void Function(double)? onChange;
  final void Function()? onDragEnd;
  final double sensitivity;
  final String suffix;

  const KnobPage(this.text, this.initialValue,
      {this.sensitivity = 1,
      this.suffix = "BPM",
      this.onChange,
      this.onDragEnd,
      Key? key})
      : super(key: key);

  @override
  State<KnobPage> createState() => _KnobPageState();
}

class _KnobPageState extends State<KnobPage> {
  double _value = 0;
  double _pValue = 0;
  late double _offset;
  late KnobController _controller;

  double get value => max(1, _value * widget.sensitivity + _offset);

  @override
  void initState() {
    _value = 0;
    _pValue = 0;
    _offset = widget.initialValue().toDouble();
    _controller = KnobController(endAngle: 360, initial: 0, startAngle: 0);
    _controller.addOnValueChangedListener((double newValue) {
      if ((_pValue.toInt()) % 100 > 90 && newValue < 10) {
        _value += 100;
      } else if ((_pValue.toInt() + 10000000) % 100 < 10 && newValue > 90) {
        if (_value * widget.sensitivity + _offset > -100 * widget.sensitivity) {
          _value -= 100;
        }
      }
      setState(() {
        _value = _value + newValue - _pValue;
      });

      _pValue = newValue;

      if (widget.onChange != null) {
        widget.onChange!(value);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.text,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "${value.toInt()}",
            style: Theme.of(context).textTheme.headline2,
          ),
          Text(widget.suffix, style: Theme.of(context).textTheme.headline6),
          const SizedBox(
            height: 30,
          ),
          Knob(
              onDragEnd: widget.onDragEnd,
              style: const KnobStyle(
                labelStyle: TextStyle(color: Colors.transparent),
                controlStyle: ControlStyle(
                    tickStyle:
                        ControlTickStyle(count: 100, margin: 20, width: 0.5),
                    glowColor: Colors.transparent,
                    shadowColor: Colors.black),
                pointerStyle: PointerStyle(color: Colors.black, offset: 10),
                minorTickStyle: MinorTickStyle(
                    color: Colors.transparent,
                    highlightColor: Colors.transparent),
                majorTickStyle: MajorTickStyle(
                    color: Colors.transparent,
                    highlightColor: Colors.transparent),
              ),
              controller: _controller),
        ],
      ),
    );
  }
}
