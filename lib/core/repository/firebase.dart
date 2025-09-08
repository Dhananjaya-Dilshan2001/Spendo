import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spendo/core/model/transaction.dart';
import 'package:spendo/core/model/user.dart';

class FirebaseRepository {
  static FirebaseFirestore instance = FirebaseFirestore.instance;

  Future<void> addUser(AppUser user) async {
    print(user.toJson());
    await instance.collection('Users').doc(user.id).set(user.toJson());
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

  Future<List<UserTransaction>> getAllTransactions(String userId) async {
    print("Fetching transactions for user ID: $userId");
    var querySnapshot =
        await instance
            .collection('Users')
            .doc(userId)
            .collection('transactions')
            .get();
    return querySnapshot.docs
        .map((doc) => UserTransaction.fromJson(doc.data()))
        .toList();
  }

  void addTransaction(AppUser user, UserTransaction transaction) async {
    var userId = user.id;
    user.transactions!.add(transaction);
    print("Adding transaction for user ID: $userId");
    await updateUser(user);
  }

  void deleteTransaction(AppUser user, String transactionId) async {
    user.transactions!.removeWhere(
      (transaction) => transaction.id == transactionId,
    );
    await updateUser(user);
  }

  Future<void> updateUser(AppUser user) async {
    var userId = user.id;
    await instance.collection('Users').doc(userId).update(user.toJson());
    print("User with ID: $userId updated successfully.");
  }

  void addACategorie(String category, AppUser user) async {
    user.categories!.add(category);
    await updateUser(user);
  }

  void deleteACategorie(String category, AppUser user) async {
    user.categories!.removeWhere((cat) => cat == category);
    await updateUser(user);
  }

  void changeUserData(String variable, var newValue, AppUser user) async {
    switch (variable) {
      case "isEnable":
        user.isEnable = newValue;
        break;
      case "monthlyBudget":
        user.monthlyBudget = newValue;
        break;
      case "monthlyExpectedIncome":
        user.monthlyExpectedIncome = newValue;
        break;
      case "monthlyExpectedOutcome":
        user.monthlyExpectedOutcome = newValue;
        break;
      default:
        print("Unknown variable: $variable");
    }
    await updateUser(user);
  }
}
