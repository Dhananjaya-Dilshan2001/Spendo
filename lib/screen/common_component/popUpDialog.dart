import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spendo/core/model/transaction.dart';
import 'package:spendo/core/model/user.dart';

class popDialog extends StatelessWidget {
  final AppUser user;
  const popDialog({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    UserTransaction newTransaction = UserTransaction(
      month: "${Timestamp.now().toDate().month}",
      isExpense: true,
      category: '',
      description: '',
      amount: 0,
      date: Timestamp.now(),
      id: Timestamp.now().toString(),
    );
    return AlertDialog(
      title: Text("Add Transaction"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<String>(
            items: [
              DropdownMenuItem(value: "Income", child: Text("Income")),
              DropdownMenuItem(value: "Expense", child: Text("Expense")),
            ],
            onChanged: (value) {
              newTransaction.isExpense = value == "Expense";
            },
            decoration: InputDecoration(labelText: "Type"),
          ),
          DropdownButtonFormField<String>(
            items: [
              ...user.categories!.map((category) {
                return DropdownMenuItem<String>(
                  value: category.toString(),
                  child: Text(category.toString()),
                );
              }).toList(),
            ],
            onChanged: (value) {
              newTransaction.category = value ?? 'Not specified';
            },
            decoration: InputDecoration(labelText: "Category"),
          ),
          TextField(
            decoration: InputDecoration(labelText: "Amount"),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              newTransaction.amount = double.tryParse(value) ?? 0;
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: "Description"),
            onChanged: (value) {
              newTransaction.description = value;
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(newTransaction);
          },
          child: Text("Add"),
        ),
      ],
    );
  }
}

class AlertMessage extends StatelessWidget {
  const AlertMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirm Delete'),
      content: Text('Are you sure you want to delete this transaction?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text('Delete'),
        ),
      ],
    );
  }
}
