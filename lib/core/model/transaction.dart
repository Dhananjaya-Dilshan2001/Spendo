import 'package:cloud_firestore/cloud_firestore.dart';

class UserTransaction {
  String month;
  bool isExpense;
  String category;
  String description;
  double amount;
  Timestamp date;
  String id;

  UserTransaction({
    required this.month,
    required this.isExpense,
    required this.category,
    required this.description,
    required this.amount,
    required this.date,
    required this.id,
  });
  // Method to convert a Transaction object to a map
  Map<String, dynamic> toMap() {
    return {
      'month': month,
      'isExpense': isExpense,
      'category': category,
      'description': description,
      'amount': amount,
      'date': date,
      'id': id,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'isExpense': isExpense,
      'category': category,
      'description': description,
      'amount': amount,
      'date': date,
      'id': id,
    };
  }

  // Method to create a UserTransaction object from a map
  factory UserTransaction.fromMap(Map<String, dynamic> map) {
    return UserTransaction(
      month: map['month'],
      isExpense: map['isExpense'],
      category: map['category'],
      description: map['description'],
      amount: map['amount'],
      date: map['date'],
      id: map['id'],
    );
  }
  factory UserTransaction.fromJson(Map<String, dynamic> json) {
    return UserTransaction(
      month: json['month'],
      isExpense: json['isExpense'],
      category: json['category'],
      description: json['description'],
      amount: json['amount'],
      date: json['date'],
      id: json['id'],
    );
  }
}
