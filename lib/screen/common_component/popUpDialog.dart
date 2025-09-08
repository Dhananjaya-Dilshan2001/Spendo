import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spendo/core/model/transaction.dart';
import 'package:spendo/core/model/user.dart';
import 'package:spendo/screen/color&theme.dart';

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
          Row(
            children: [
              Text("Date: "),
              Text(
                "${newTransaction.date.toDate().day}-${newTransaction.date.toDate().month}-${newTransaction.date.toDate().year}",
              ),
              IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: newTransaction.date.toDate(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    newTransaction.date = Timestamp.fromDate(pickedDate);
                  }
                },
              ),
            ],
          ),
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
  final String title;
  final String content;
  const AlertMessage({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.color2,
      titleTextStyle: TextStyle(
        color: AppColors.color6,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      title: Text(title),
      content: Text(content),
      contentTextStyle: TextStyle(color: AppColors.color6, fontSize: 16),

      actions: [
        TextButton(
          style: TextButton.styleFrom(foregroundColor: AppColors.color6),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text('Cancel'),
        ),
        TextButton(
          style: TextButton.styleFrom(foregroundColor: AppColors.color6),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text('Delete'),
        ),
      ],
    );
  }
}

class SimpleUserInput extends StatelessWidget {
  final String title;
  final String hintText;
  final String variableName;
  const SimpleUserInput({
    super.key,
    required this.title,
    required this.hintText,
    required this.variableName,
  });

  @override
  Widget build(BuildContext context) {
    String newCategory = '';
    return AlertDialog(
      surfaceTintColor: AppColors.color1,
      backgroundColor: AppColors.color6,
      titleTextStyle: TextStyle(
        color: AppColors.color1,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      buttonPadding: const EdgeInsets.all(8),
      title: Text(title),
      content: TextField(
        onChanged: (value) {
          newCategory = value;
        },
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: AppColors.color1),
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.color6,
            backgroundColor: AppColors.color1,
          ),
          onPressed: () {
            Navigator.of(context).pop(newCategory);
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}
