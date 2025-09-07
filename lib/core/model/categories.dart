import 'dart:ui';
import 'package:spendo/screen/color&theme.dart';

class Categories {
  bool isExpense;
  String name;
  Color color;

  Categories({
    required this.isExpense,
    required this.name,
    this.color = AppColors.color1,
  });
  // Method to convert a Categories object to a map
  Map<String, dynamic> toMap() {
    return {'isExpense': isExpense, 'name': name, 'color': color.value};
  }

  Map<String, dynamic> toJson() {
    return {'isExpense': isExpense, 'name': name, 'color': color.value};
  }

  // Method to create a Categories object from a map
  factory Categories.fromMap(Map<String, dynamic> map) {
    return Categories(
      isExpense: map['isExpense'],
      name: map['name'],
      color: Color(map['color']),
    );
  }
  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(
      isExpense: json['isExpense'],
      name: json['name'],
      color: Color(json['color']),
    );
  }
}
