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
      tileColor:
          widget.transaction.isExpense
              ? AppColors.color3.withOpacity(0.1)
              : AppColors.color2.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: AppColors.color6, width: 2),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: height * 0.00,
      ),
      leading: CircleAvatar(
        radius: width * 0.06,
        backgroundColor: AppColors.color1,
        child: Icon(
          size: width * 0.06,
          widget.transaction.isExpense ? Icons.call_made : Icons.call_received,
          color: Colors.white,
        ),
      ),
      title: Text(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        widget.transaction.category,
        style: TextStyle(
          fontSize: width * 0.04,
          fontWeight: FontWeight.bold,
          color: AppColors.color1,
        ),
      ),
      subtitle: Text(
        widget.transaction.description,
        style: TextStyle(fontSize: width * 0.035, color: Colors.grey),
      ),
      trailing: Text(
        '${widget.transaction.isExpense ? '-' : '+'} Rs ${widget.transaction.amount}',
        style: TextStyle(
          fontSize: width * 0.04,
          fontWeight: FontWeight.bold,
          color:
              widget.transaction.isExpense
                  ? AppColors.color2
                  : AppColors.color3,
        ),
      ),
    );
  }
}
