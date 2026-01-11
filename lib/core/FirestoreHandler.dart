import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app1/model/user/user_model.dart';

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
}