import 'package:flutter/material.dart';
import 'package:spendo/core/model/transaction.dart';
import 'package:spendo/screen/color&theme.dart';

class ListCard1 extends StatefulWidget {
  final VoidCallback? onLongPress;
  final UserTransaction transaction;
  const ListCard1({super.key, required this.transaction, this.onLongPress});

  @override
  State<ListCard1> createState() => _ListCard1State();
}

class _ListCard1State extends State<ListCard1> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ListTile(
      onLongPress: () {
        widget.onLongPress?.call();
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: AppColors.color5, width: 2),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: height * 0.005,
      ),
      leading: CircleAvatar(
        backgroundColor: AppColors.color1,
        child: Icon(
          widget.transaction.isExpense ? Icons.remove : Icons.add,
          color: Colors.white,
        ),
      ),
      title: Text(
        widget.transaction.category,
        style: TextStyle(
          fontSize: width * 0.04,
          fontWeight: FontWeight.bold,
          color: AppColors.color1,
        ),
      ),
      subtitle: Text(
        widget.transaction.description,
        style: TextStyle(fontSize: width * 0.03, color: Colors.grey),
      ),
      trailing: Text(
        '${widget.transaction.isExpense ? '-' : '+'} Rs ${widget.transaction.amount}',
        style: TextStyle(
          fontSize: width * 0.04,
          fontWeight: FontWeight.bold,
          color: AppColors.color2,
        ),
      ),
    );
  }
}
