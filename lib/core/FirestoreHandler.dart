import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app1/model/user/user_model.dart';

import '../model/event/event_model.dart';

class FirestoreHandler {


  CollectionReference<UserModel> getUserCollection(){
    var collection = FirebaseFirestore.instance.collection("users").withConverter(
        fromFirestore:(snapshot, _) => UserModel.fromFirestore(snapshot.data()!),
        toFirestore: (user, _) => user.toFirestore()
    );
    return collection;
  }

  Future<void> addUser(UserModel user)async{
   var collection = getUserCollection();
   var document = collection.doc(user.id);
     return  document.set(user);
}

  Future<UserModel?> getUser(String id)async{
    var collection = getUserCollection();
    var document = collection.doc(id);
    var snapshot = await document.get();
    return snapshot.data();


  }

  CollectionReference<EventModel> getEventCollection() {
    var collection = FirebaseFirestore.instance.collection("events").withConverter(
        fromFirestore: (snapshot, _) => EventModel.fromFirestore(snapshot.data()!)
        , toFirestore: (event, _) => event.toFirestore()
    );
    return collection;
  }

  Future<void> addEvent(EventModel event)async{
    var collection = getEventCollection();
    var document = collection.doc();
    event.id = document.id;
    return document.set(event);

  }

  Future<List<EventModel>> getEvents()async{
    var collection = getEventCollection();
    var snapshot =await collection.get();
    var documents = snapshot.docs;
    var eventsList = documents.map((doc) => doc.data()).toList();
    return eventsList;
  }

  Future<List<EventModel>> getEventsByType(String type)async{
    var collection = getEventCollection().where("type" , isEqualTo: type);
    var snapshot =await collection.get();
    var documents = snapshot.docs;
    var eventsList = documents.map((doc) => doc.data()).toList();
    return eventsList;
  }

  Stream<List<EventModel>> getEventsStream()async*{
    var collection = getEventCollection();
    var snapshot =await collection.snapshots();
    var eventStream = snapshot.map((snapshot){
      var documents = snapshot.docs;
      var eventsList = documents.map((doc) => doc.data()).toList();
      return eventsList;
    });
     yield* eventStream;
  }

  Stream<List<EventModel>> getEventsByTypeStream(String type)async*{
    var collection = getEventCollection().where("type" , isEqualTo: type);
    var snapshot =await collection.snapshots();
    var eventStream = snapshot.map((snapshot){
      var documents = snapshot.docs;
      var eventsList = documents.map((doc) => doc.data()).toList();
      return eventsList;
    });
    yield* eventStream;
  }


  }
