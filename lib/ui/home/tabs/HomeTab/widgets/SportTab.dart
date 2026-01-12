import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/FirestoreHandler.dart';
import '../../../../../model/event/event_model.dart';
import '../../../widgets/EventItem.dart';

class SportTab extends StatefulWidget {
  const SportTab({super.key});

  @override
  State<SportTab> createState() => _SportTabState();
}
class _SportTabState extends State<SportTab> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<EventModel>>(
      stream: FirestoreHandler().getEventsByTypeStream("Sport"),
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
          return Center(child: const Text("No Sport Events" , style: TextStyle(fontSize: 20),));
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
