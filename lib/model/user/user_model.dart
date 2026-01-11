class UserModel{
  String? id ;
  String? name;
  String? email;

  UserModel({
    required this.id ,
    required this.name ,
    required this.email
  });


  UserModel.fromFirestore(Map<String, dynamic> data){
    id = data['id'];
    name = data['name'];
    email = data['email'];
  }

  Map<String, String?> toFirestore() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }




}