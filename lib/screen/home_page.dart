import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spendo/core/bloc/bloc/user_bloc.dart';
import 'package:spendo/core/repository/firebase.dart';
import 'package:spendo/screen/color&theme.dart';
import 'package:spendo/screen/common_component/tab%20view/analytic_page.dart';
import 'package:spendo/screen/common_component/tab%20view/dashboard.dart';
import 'package:spendo/screen/common_component/tab%20view/history_page.dart';
import 'package:spendo/screen/common_component/tab%20view/plan_page.dart';

class HomePage extends StatefulWidget {
  final String userId;
  const HomePage({super.key, required this.userId});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseRepository firebase = FirebaseRepository();

  @override
  void initState() {
    context.read<UserBloc>().add(LoadUsers(userId: widget.userId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.color6,
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app, color: AppColors.color1),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/logging');
              },
            ),
          ],
          backgroundColor: AppColors.color6,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: AppColors.color1,
                child: Icon(Icons.person, color: Colors.white),
                radius: 16,
              ),
              const SizedBox(width: 8),
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserLoaded) {
                    return Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      'Hello, ${state.user.name}..!',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                        fontWeight: FontWeight.bold,
                        color: AppColors.color1,
                      ),
                    );
                  } else if (state is UserLoading) {
                    return const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.color1,
                    );
                  } else if (state is UserError) {
                    return Text(
                      'Error: ${state.message}',
                      style: const TextStyle(color: Colors.red),
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: AppColors.color5,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: TabBar(
            indicatorColor: AppColors.color1,
            labelColor: AppColors.color1,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(icon: Icon(Icons.dashboard), text: 'Dashboard'),
              Tab(icon: Icon(Icons.list), text: 'History'),
              Tab(icon: Icon(Icons.settings), text: 'Plan'),
              Tab(icon: Icon(Icons.pie_chart), text: 'Overview'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Dashboard(userId: widget.userId),
            HistoryPage(),
            PlanPage(),
            AnalyticPage(),
          ],
        ),
      ),
    );
  }
}
