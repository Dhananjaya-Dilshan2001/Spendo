import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:spendo/core/bloc/bloc/user_bloc.dart';
import 'package:spendo/screen/color&theme.dart';
import 'package:spendo/screen/common_component/ListCard.dart';
import 'package:spendo/screen/common_component/component.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    context.read<UserBloc>().add(LoadUsers(userId: '1155555'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    String dayName = DateFormat('EEEE').format(DateTime.now());
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        print("User State in Dashboard: $state");
        if (state is UserLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is UserLoaded) {
          return Stack(
            children: [
              Positioned(
                right: width * 0.05,
                bottom: height * 0.02,
                child: IconButton(
                  onPressed: () {},
                  icon: CircleAvatar(
                    backgroundColor: AppColors.color1,
                    child: Icon(Icons.add, color: AppColors.color5),
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: height * 0.01),
                  Text(
                    dayName,
                    style: TextStyle(
                      fontSize: width * 0.06,
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
                          amount: "Rs ${state.user.monthlyBudget}",
                          color: AppColors.color5,
                          amountFontSize: width * 0.05,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: width * 0.4,
                              //color: AppColors.color3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Income : 10,000/=',
                                    style: TextStyle(
                                      fontSize: width * 0.03,
                                      color: AppColors.color5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Out come : 10,000/=',
                                    style: TextStyle(
                                      fontSize: width * 0.03,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.color5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: width * 0.4,
                              //color: AppColors.color5,
                              child: const Icon(
                                Icons.bar_chart,
                                color: AppColors.color5,
                                size: 32,
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
                      'Today : 2025 March 10',
                      style: TextStyle(
                        fontSize: width * 0.03,
                        fontWeight: FontWeight.bold,
                        color: AppColors.color1,
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Expanded(
                    child: Container(
                      width: width * 0.9,
                      //color:AppColors.color2, // Set the background color of the container
                      child: ListView(
                        children: [...List.generate(5, (index) => ListCard1())],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
