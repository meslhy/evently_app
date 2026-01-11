import 'package:flutter/material.dart';

import '../../../widgets/EventItem.dart';

class HomeTabScreen extends StatelessWidget {
  static const String routeName = "HomeTabScreen";
  const HomeTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: ListView.separated(
          itemBuilder: (context, index) => EventItem(),
          separatorBuilder: (context, index) => SizedBox(height: 10),
          itemCount: 10),
    );
  }
}
