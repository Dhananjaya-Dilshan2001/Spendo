import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spendo/core/model/transaction.dart';
import 'package:spendo/core/model/user.dart';
import 'package:spendo/screen/color&theme.dart';

class FirebaseRepository {
  static FirebaseFirestore instance = FirebaseFirestore.instance;

  Future<bool> isUserExist(String userId) async {
    var doc = await instance.collection('Users').doc(userId).get();
    return doc.exists;
  }

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

  void addTransaction(
    BuildContext context,
    AppUser user,
    UserTransaction transaction,
  ) async {
    var userId = user.id;
    user.transactions!.add(transaction);
    print("Adding transaction for user ID: $userId");
    await updateUser(context, user, "Transaction added successfully.");
  }

  void deleteTransaction(
    BuildContext context,
    AppUser user,
    String transactionId,
  ) async {
    user.transactions!.removeWhere(
      (transaction) => transaction.id == transactionId,
    );
    await updateUser(context, user, "Transaction deleted successfully.");
  }

  Future<void> updateUser(
    BuildContext context,
    AppUser user,
    String msg,
  ) async {
    var userId = user.id;
    await instance.collection('Users').doc(userId).update(user.toJson());
    print("User with ID: $userId updated successfully.");
    showSimpleSnackbar(context, msg);
  }

  void addACategorie(
    BuildContext context,
    String category,
    AppUser user,
  ) async {
    user.categories!.add(category);
    await updateUser(context, user, "Category added successfully.");
  }

  void deleteACategorie(
    BuildContext context,
    String category,
    AppUser user,
  ) async {
    user.categories!.removeWhere((cat) => cat == category);
    await updateUser(context, user, "Category deleted successfully.");
  }

  void changeUserData(
    BuildContext context,
    String variable,
    var newValue,
    AppUser user,
  ) async {
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
    await updateUser(context, user, "User data updated successfully.");
  }
}

void showSimpleSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.color1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: Row(
        children: [
          Icon(Icons.check_circle, color: Colors.white, size: 28),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              message,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
