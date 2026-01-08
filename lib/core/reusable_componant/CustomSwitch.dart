import 'dart:async';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:evently_app1/core/resources/ColorManager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSwitch extends StatelessWidget {
  String item1;
  String item2;
  bool isColored;
  int selected;
  FutureOr<void> Function(int) onChanged;

  CustomSwitch({
    super.key,
    required this.item1,
    required this.item2,
    this.isColored = false,
    required this.selected,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedToggleSwitch<int>.rolling(
        current: selected,
        values: [0, 1,],
       iconList: [
         SvgPicture.asset(item1 , height: 30, width: 30,
           colorFilter:isColored? ColorFilter.mode(
               selected == 0? Theme.of(context).colorScheme.onPrimary :Theme.of(context).colorScheme.primary
           , BlendMode.srcIn) : null,
         ),
         SvgPicture.asset(item2 ,
           height: 30,
           width: 30,
           colorFilter:isColored? ColorFilter.mode(
               selected == 1? Theme.of(context).colorScheme.onPrimary :Theme.of(context).colorScheme.primary
               , BlendMode.srcIn) : null,
         )
       ],
      iconOpacity: 1,
      style:ToggleStyle(
        borderColor: Theme.of(context).colorScheme.primary,
        indicatorColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Colors.transparent,
      ),
      onChanged: onChanged,
    );
  }
}
