import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spendo/core/bloc/bloc/user_bloc.dart';
import 'package:spendo/core/repository/firebase.dart';
import 'package:spendo/screen/color&theme.dart';
import 'package:spendo/screen/common_component/bar_graph.dart';
import 'package:spendo/screen/common_component/buttons.dart';
import 'package:spendo/screen/common_component/category_card.dart';
import 'package:spendo/screen/common_component/plan_card.dart';
import 'package:spendo/screen/common_component/popUpDialog.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({super.key});

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  @override
  Widget build(BuildContext context) {
    FirebaseRepository firebase = FirebaseRepository();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is UserLoaded) {
          return Container(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: height * 0.01),

              children: [
                SizedBox(height: height * 0.01),
                Center(
                  child: Text(
                    'Monthly Spending Planning',
                    style: TextStyle(
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.bold,
                      color: AppColors.color1,
                    ),
                  ),
                ),
                Container(
                  height: height * 0.25,
                  margin: EdgeInsets.all(width * 0.04),
                  padding: EdgeInsets.symmetric(
                    vertical: width * 0.04,
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
                  child: MyBarGraph(
                    balance: state.user.monthlyBudget ?? 0.0,
                    totalIncome: state.user.monthlyExpectedIncome ?? 0.0,
                    totalExpense: state.user.monthlyExpectedOutcome ?? 0.0,
                    width: width,
                    height: height,
                  ),
                ),
                SizedBox(height: height * 0.02),
                PlanCard(
                  color: AppColors.color1,
                  title: "Monthly Budget",
                  amount: "${state.user.monthlyBudget}",
                  onPressed: () {
                    chnageBudgetValueController(
                      context,
                      firebase,
                      state,
                      "monthlyBudget",
                    );
                  },
                ),
                PlanCard(
                  color: AppColors.color3,
                  title: "Expected Income",
                  amount: "${state.user.monthlyExpectedIncome}",
                  onPressed: () {
                    chnageBudgetValueController(
                      context,
                      firebase,
                      state,
                      "monthlyExpectedIncome",
                    );
                  },
                ),
                PlanCard(
                  color: AppColors.color2,
                  title: "Expected Outcome",
                  amount: "${state.user.monthlyExpectedOutcome}",
                  onPressed: () {
                    chnageBudgetValueController(
                      context,
                      firebase,
                      state,
                      "monthlyExpectedOutcome",
                    );
                  },
                ),
                SizedBox(height: height * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'My Categories',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: width * 0.05,
                        color: AppColors.color1,
                      ),
                    ),
                    Mybutton1(
                      label: 'Add New',
                      onPressed: () {
                        var categorie = showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            String newCategory = '';
                            return SimpleUserInput(
                              title: 'Add New Category',
                              hintText: 'Enter category name',
                              variableName: newCategory,
                            );
                          },
                        );
                        categorie.then((value) {
                          if (value != null && value.isNotEmpty) {
                            firebase.addACategorie(value, state.user);
                          }
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: height * 0.02),
                Wrap(
                  spacing: width * 0.05,
                  runSpacing: height * 0.02,
                  children: [
                    ...List.generate(
                      state.user.categories!.length,
                      (index) => CategoryCard(
                        color: AppColors.color4,
                        categoryName: state.user.categories![index],
                        onLongPress: () {
                          var confirmDelete = showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertMessage(
                                title: 'Confirm Delete',
                                content:
                                    'Are you sure you want to delete this category?',
                              );
                            },
                          );
                          if (confirmDelete == true) {
                            firebase.deleteACategorie(
                              state.user.categories![index],
                              state.user,
                            );
                            setState(() {});
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.02),
              ],
            ),
          );
        }
        return CircleAvatar();
      },
    );
  }

  void chnageBudgetValueController(
    BuildContext context,
    FirebaseRepository firebase,
    UserLoaded state,
    String variableName,
  ) {
    var budget = showDialog(
      context: context,
      builder: (BuildContext context) {
        String newBudget = '';
        return SimpleUserInput(
          title: 'Update $variableName',
          hintText: 'Enter new $variableName amount',
          variableName: newBudget,
        );
      },
    );
    budget.then((value) {
      if (value != null && value.isNotEmpty) {
        firebase.changeUserData(variableName, double.parse(value), state.user);
        setState(() {});
      }
    });
  }
}
