import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/FirestoreHandler.dart';
import '../../../../../model/event/event_model.dart';
import '../../../widgets/EventItem.dart';

class BirthdayTab extends StatefulWidget {
  const BirthdayTab({super.key});

  @override
  State<BirthdayTab> createState() => _BirthdayTabState();
}

class _BirthdayTabState extends State<BirthdayTab> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<EventModel>>(
      stream: FirestoreHandler().getEventsByTypeStream("Birthday"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Skeletonizer(
            enabled: ConnectionState.waiting == true ? true : false,
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return EventItem(eventModel: EventModel.skeleton()); // نفس الشكل الحقيقي
              },
            ),
          );

        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: const Text("No Birthday Events" , style: TextStyle(fontSize: 20),));
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return EventItem(eventModel: snapshot.data![index]);
          },
        );
      },
    );
  }
}
