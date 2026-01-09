import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  void Function()? onPressed;
  String title;
  CustomTextButton({
    super.key,
    required this.onPressed,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.blue
          ),
        ),

    );
  }
}
