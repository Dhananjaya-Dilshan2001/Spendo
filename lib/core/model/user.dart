import 'package:spendo/core/model/transaction.dart';

class AppUser {
  String id;
  String name;
  String email;
  double? monthlyBudget;
  double? monthlyExpectedIncome;
  double? monthlyExpectedOutcome;
  List<String>? categories;
  List<UserTransaction>? transactions;
  bool isEnable;
  AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.monthlyBudget,
    required this.monthlyExpectedIncome,
    required this.monthlyExpectedOutcome,
    this.categories = const [],
    this.transactions = const [],
    this.isEnable = true,
  });
  // Method to convert a Person object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'monthlyBudget': monthlyBudget,
      'monthlyExpectedIncome': monthlyExpectedIncome,
      'monthlyExpectedOutcome': monthlyExpectedOutcome,
      'categories': categories?.map((category) => category).toList(),
      'transactions':
          transactions?.map((transaction) => transaction.toMap()).toList(),
      'isEnable': isEnable,
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'monthlyBudget': monthlyBudget,
      'monthlyExpectedIncome': monthlyExpectedIncome,
      'monthlyExpectedOutcome': monthlyExpectedOutcome,
      'categories': categories?.map((category) => category).toList(),
      'transactions':
          transactions?.map((transaction) => transaction.toJson()).toList(),
      'isEnable': isEnable,
    };
  }

  // Method to create a Person object from a map
  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      monthlyBudget: map['monthlyBudget'],
      monthlyExpectedIncome: map['monthlyExpectedIncome'],
      monthlyExpectedOutcome: map['monthlyExpectedOutcome'],
      categories:
          (map['categories'] as List<dynamic>?)
              ?.map((category) => category.toString())
              .toList(),
      transactions:
          (map['transactions'] as List<dynamic>?)
              ?.map((transaction) => UserTransaction.fromMap(transaction))
              .toList(),
      isEnable: map['isEnable'],
    );
  }
  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      monthlyBudget: json['monthlyBudget'],
      monthlyExpectedIncome: json['monthlyExpectedIncome'],
      monthlyExpectedOutcome: json['monthlyExpectedOutcome'],
      categories:
          (json['categories'] as List<dynamic>?)
              ?.map((category) => category.toString())
              .toList(),
      transactions:
          (json['transactions'] as List<dynamic>?)
              ?.map((transaction) => UserTransaction.fromJson(transaction))
              .toList(),
      isEnable: json['isEnable'],
    );
  }
}
