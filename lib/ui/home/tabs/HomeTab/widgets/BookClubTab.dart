import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/FirestoreHandler.dart';
import '../../../../../model/event/event_model.dart';
import '../../../widgets/EventItem.dart';

class Bookclubtab extends StatefulWidget {
  const Bookclubtab({super.key});

  @override
  State<Bookclubtab> createState() => _BookclubtabState();
}

class _BookclubtabState extends State<Bookclubtab> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<EventModel>>(
      stream: FirestoreHandler().getEventsByTypeStream("Book Club"),
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
          return Center(child: const Text("No Book Club Events" , style: TextStyle(fontSize: 20),));
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
