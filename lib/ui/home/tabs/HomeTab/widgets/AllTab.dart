import 'package:evently_app1/core/FirestoreHandler.dart';
import 'package:evently_app1/model/event/event_model.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../widgets/EventItem.dart';

class AllTab extends StatefulWidget {


   AllTab({super.key});

  @override
  State<AllTab> createState() => _AllTabState();
}

class _AllTabState extends State<AllTab> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<EventModel>>(
      stream: FirestoreHandler().getEventsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Skeletonizer(
            enabled:snapshot.connectionState == ConnectionState.waiting,
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return EventItem(eventModel: EventModel.skeleton());
              },
            ),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text("No Any Events");
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
