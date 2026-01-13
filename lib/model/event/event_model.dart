import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String? id;
  String? userId;
  String? title;
  String? description;
  String? type;
  Timestamp? date;
  double latitude = 0.0;
  double longitude = 0.0;
  List<String>? favoriteUsersId;

  EventModel({
    this.id,
    this.title,
    this.description,
    this.type,
    this.date,
    this.latitude =0.0,
    this.longitude = 0.0,
    this.userId,
    this.favoriteUsersId,
  });

  factory EventModel.skeleton() {
    return EventModel(
      title: 'Loading',
      description: 'Loading',
      type: 'Loading',
      date: Timestamp.now(),
      latitude: 0,
      longitude: 0,
      favoriteUsersId: const [],
    );
  }

  EventModel.fromFirestore(Map<String, dynamic>? json){
    id = json?['id'];
    userId = json?['userId'];
    title = json?['title'];
    description = json?['description'];
    type = json?['type'];
    date = json?['date'];
    latitude = (json?['latitude']?? 0.0).toDouble() ;
    longitude = (json?['longitude'] ?? 0.0).toDouble() ;
    favoriteUsersId = json?['favoriteUsersId'] == null ? [] : List<String>.from(json?['favoriteUsersId']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'type': type,
      'date': date,
      'latitude': latitude,
      'longitude': longitude,
      'favoriteUsersId': favoriteUsersId,
    };
  }

  }
