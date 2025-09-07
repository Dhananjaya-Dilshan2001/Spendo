import 'package:flutter/material.dart';
import 'package:spendo/screen/color&theme.dart';
import 'package:spendo/screen/common_component/analytic_page.dart';
import 'package:spendo/screen/common_component/dashboard.dart';
import 'package:spendo/screen/common_component/history_page.dart';
import 'package:spendo/screen/common_component/plan_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppColors.color6,
        appBar: AppBar(
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
              const Text(
                'Hello User!',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.color1,
                ),
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
              Tab(icon: Icon(Icons.pie_chart), text: 'Stats'),
              Tab(icon: Icon(Icons.settings), text: 'Settings'),
            ],
          ),
        ),
        body: TabBarView(
          children: [Dashboard(), HistoryPage(), PlanPage(), AnalyticPage()],
        ),
      ),
    );
  }
}
