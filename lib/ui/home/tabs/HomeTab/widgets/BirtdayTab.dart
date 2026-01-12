import 'package:flutter/material.dart';

import '../../../widgets/EventItem.dart';

class BirthdayTab extends StatelessWidget {
  const BirthdayTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => EventItem(),
        separatorBuilder: (context, index) => SizedBox(height: 10),
        itemCount: 3);
  }
}
