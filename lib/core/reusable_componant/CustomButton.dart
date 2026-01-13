import 'package:flutter/material.dart';

import '../resources/ColorManager.dart';

class CustomButton extends StatelessWidget {
  String title;
  void Function() onTap;
  Color? color;

  CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style:ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 16
        ),
        backgroundColor:color ?? Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
        ),

      ) ,
        onPressed: onTap,
        child:Text(
          title,
          style: Theme.of(context).textTheme.labelMedium,
        ) );

  }
}
