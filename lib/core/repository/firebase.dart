import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spendo/core/model/user.dart';

class FirebaseRepository {
  static FirebaseFirestore instance = FirebaseFirestore.instance;

  Future<List<AppUser>> getAllUsers() async {
    var snapshot = await instance.collection('Users').get();

    return snapshot.docs.map((doc) => AppUser.fromJson(doc.data())).toList();
  }

  Future<void> addUser(AppUser user) async {
    print(user.toJson());
    await instance.collection('Users').doc(user.id).set(user.toJson());
  }

  Future<void> updateUser(AppUser user) async {
    await instance.collection('Users').doc(user.id).update(user.toJson());
  }

  Future<void> deleteUser(String id) async {
    await instance.collection('Users').doc(id).delete();
  }

  Future<AppUser?> getUserByID(String id) async {
    var doc = await instance.collection('Users').doc(id).get();
    if (doc.exists) {
      return AppUser.fromJson(doc.data()!);
    }
    return null;
  }
}
