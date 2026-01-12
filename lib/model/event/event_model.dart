import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String? id;
  String? userId;
  String? title;
  String? description;
  String? type;
  Timestamp? date;
  double? latitude;
  double? longitude;
  List<String>? favoriteUsersId;

  EventModel({
    this.id,
    this.title,
    this.description,
    this.type,
    this.date,
    this.latitude,
    this.longitude,
    this.userId,
    this.favoriteUsersId,
  });

  factory EventModel.skeleton() {
    return EventModel(
      title: '',
      type: '',
      date: Timestamp.now(),
    );
  }

  EventModel.fromFirestore(Map<String, dynamic>? json){
    id = json?['id'];
    userId = json?['userId'];
    title = json?['title'];
    description = json?['description'];
    type = json?['type'];
    date = json?['date'];
    latitude = json?['latitude'];
    longitude = json?['longitude'];
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
