import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app1/model/user/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


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


  final googleSignIn = GoogleSignIn.instance;

  Future<UserModel?> signInWithGoogle() async {
    // Initialize
    await googleSignIn.initialize();

    // Authenticate
    final user = await googleSignIn.authenticate(
      scopeHint: ['email'],
    );

    if (user == null) return null;

    final googleAuth = await user.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: "840340548876-3pmdij5e5ms8ie90fbr12edto8e1qn5r.apps.googleusercontent.com",
    );

    // تسجيل الدخول في Firebase
    final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    // تحويل Firebase User → UserModel
    return userCredential.user != null
        ? UserModel(
      id: FirebaseAuth.instance.currentUser!.uid,
      name: userCredential.user!.displayName,
      email: userCredential.user!.email,

    )
        : null;
  }



}
