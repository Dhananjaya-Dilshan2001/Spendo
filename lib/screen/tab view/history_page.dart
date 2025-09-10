import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spendo/core/bloc/bloc/user_bloc.dart';
import 'package:spendo/screen/color&theme.dart';
import 'package:spendo/screen/common_component/ListCard.dart';
import 'package:spendo/screen/common_component/component.dart';
import 'package:spendo/screen/common_component/popUpDialog.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Timestamp selectedDate = Timestamp.now();
  bool all = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is UserLoaded) {
          print("Created History Page");
          double totalIncome = state.totalIncome();
          double totalExpense = state.totalExpense();
          double balance = totalIncome - totalExpense;

          var children = [
            ...List.generate(
              state.displayedTransactionList.length,
              (index) => ListCard1(
                onLongPress: () async {
                  await transactionDeleteController(
                    context,
                    state,
                    state.displayedTransactionList[index].id,
                  );
                },
                transaction: state.displayedTransactionList[index],
              ),
            ),
          ]; // Generate ListCard1 widgets for each transaction
          return Container(
            child: Column(
              children: [
                SizedBox(height: height * 0.01),
                Text(
                  'Total Transaction History',
                  style: TextStyle(
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.bold,
                    color: AppColors.color1,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(width * 0.04),
                  padding: EdgeInsets.symmetric(
                    vertical: width * 0.08,
                    horizontal: width * 0.08,
                  ),
                  width: width * 0.9,
                  decoration: BoxDecoration(
                    color: AppColors.color5,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyWidget1(
                        title: "Budget",
                        amount: "Rs $balance",
                        color:
                            balance > 0 ? AppColors.color3 : AppColors.color2,
                        amountFontSize: width * 0.06,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyWidget1(
                            title: "Total Income",
                            amount: "Rs $totalIncome",
                            color: AppColors.color3,
                            amountFontSize: width * 0.045,
                          ),
                          MyWidget1(
                            title: "Total Outcome",
                            amount: "Rs $totalExpense",
                            color: AppColors.color2,
                            amountFontSize: width * 0.045,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02),
                Container(
                  width: width * 0.85,
                  child: Row(
                    children: [
                      FilledButton(
                        style: FilledButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          side: BorderSide(
                            width: 1.5,
                            color:
                                all
                                    ? AppColors.color1
                                    : AppColors.color1.withOpacity(0.5),
                          ),
                          backgroundColor:
                              all ? AppColors.color1 : Colors.transparent,
                        ),
                        onPressed: () {
                          setState(() {
                            all = !all;
                            if (all) {
                              state.displayedTransactionList =
                                  state.user.transactions!;
                            } else {
                              state.setTransactionListByDate(selectedDate);
                            }
                          });
                        },
                        child: Text(
                          'All',
                          style: TextStyle(
                            fontSize: width * 0.035,
                            fontWeight: FontWeight.bold,
                            color: all ? AppColors.color6 : AppColors.color1,
                          ),
                        ),
                      ),

                      SizedBox(width: width * 0.03),
                      IconButton(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.05,
                          vertical: width * 0.00,
                        ),
                        style: IconButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: AppColors.color1,
                        ),
                        onPressed: () async {
                          all = false;
                          await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          ).then((pickedDate) {
                            if (pickedDate != null) {
                              setState(() {
                                selectedDate = Timestamp.fromDate(pickedDate);
                                state.setTransactionListByDate(selectedDate);
                              });
                            }
                          });
                        },
                        icon: Icon(
                          Icons.calendar_month,
                          size: width * 0.04,
                          color: AppColors.color6,
                        ),
                      ),
                      SizedBox(width: width * 0.02),
                      Visibility(
                        visible: !all,
                        child: Text(
                          '${selectedDate.toDate().toLocal().toString().split(' ')[0]}',
                          style: TextStyle(
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.bold,
                            color: AppColors.color1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyDropdownButton(
                      isCategory: false,
                      items: ['All', 'Income', 'Expense'],
                      onChanged: () {
                        setState(() {});
                      },
                    ),
                    MyDropdownButton(
                      isCategory: true,
                      items: ["Category", ...state.user.categories!],
                      onChanged: () => setState(() {}),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(width * 0.04),
                    children: children,
                  ),
                ),
              ],
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }

  Future<void> transactionDeleteController(
    BuildContext context,
    UserLoaded state,
    String id,
  ) async {
    var confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertMessage(
          title: 'Confirm Delete',
          content: 'Are you sure you want to delete this transaction?',
        );
      },
    );
    if (confirmDelete == true) {
      state.deleteTransaction(context, id);

      setState(() {});
    }
  }
}
