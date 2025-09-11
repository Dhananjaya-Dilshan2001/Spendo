import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:spendo/core/bloc/bloc/user_bloc.dart';
import 'package:spendo/core/model/transaction.dart';
import 'package:spendo/screen/color&theme.dart';
import 'package:spendo/screen/common_component/ListCard.dart';
import 'package:spendo/screen/common_component/bar_graph.dart';
import 'package:spendo/screen/common_component/buttons.dart';
import 'package:spendo/screen/common_component/component.dart';
import 'package:spendo/screen/common_component/popUpDialog.dart';

class Dashboard extends StatefulWidget {
  final String userId;
  const Dashboard({super.key, required this.userId});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String dayName = DateFormat('EEEE').format(DateTime.now());
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is UserLoaded) {
          state.setTodayTransactionList();
          return Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: height * 0.01),
                  Text(
                    dayName,
                    style: TextStyle(
                      fontSize: width * 0.07,
                      fontWeight: FontWeight.bold,
                      color: AppColors.color1,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(width * 0.04),
                    padding: EdgeInsets.all(width * 0.04),
                    width: width * 0.9,
                    decoration: BoxDecoration(
                      color: AppColors.color1,
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
                          title: "Remaining Balance",
                          amount:
                              "Rs ${state.user.monthlyBudget! - state.totalExpense()}",
                          color: AppColors.color5,
                          amountFontSize: width * 0.07,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: width * 0.4,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyWidget1(
                                    title: "Income",
                                    amount:
                                        "Rs ${state.totalIncome().toStringAsFixed(2)}",
                                    color: AppColors.color5,
                                    amountFontSize: width * 0.04,
                                  ),
                                  SizedBox(height: height * 0.01),
                                  MyWidget1(
                                    title: "Outcome",
                                    amount:
                                        "Rs ${state.totalExpense().toStringAsFixed(2)}",
                                    color: AppColors.color5,
                                    amountFontSize: width * 0.04,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: height * 0.15,
                              width: width * 0.4,
                              //color: AppColors.color5,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MyBarGraph(
                                  barColors: [
                                    AppColors.color5,
                                    AppColors.color3,
                                    AppColors.color2,
                                  ],
                                  width: width * 0.4,
                                  height: height * 0.05,
                                  balance: state.user.monthlyBudget ?? 0.0,
                                  totalIncome: state.totalIncome(),
                                  totalExpense: state.totalExpense(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Container(
                    width: width * 0.85,
                    child: Text(
                      'Today : ${DateFormat('yyyy MMMM dd').format(DateTime.now())}',
                      style: TextStyle(
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.bold,
                        color: AppColors.color1,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Expanded(
                    child: Container(
                      width: width * 0.9,
                      child: ListView(
                        children: [
                          ...List.generate(
                            state.displayedTransactionList.length,
                            (index) => ListCard1(
                              transaction:
                                  state.displayedTransactionList[index],
                              state: state,
                              onLongPress: () {
                                deleteTransactionController(
                                  context,
                                  state,
                                  state.displayedTransactionList[index].id,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                right: width * 0.05,
                bottom: height * 0.02,
                child: Mybutton1(
                  label: "Add",
                  onPressed: () {
                    addTransactionController(context, state);
                  },
                ),
              ),
            ],
          );
        }
        return CircularProgressIndicator();
      },
    );
  }

  void addTransactionController(BuildContext context, UserLoaded state) async {
    var transaction = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return popDialog(user: state.user);
      },
    );
    if (transaction != null && transaction is UserTransaction) {
      state.addTransaction(context, transaction);
      setState(() {});
    }
    setState(() {});
  }

  Future<void> deleteTransactionController(
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
