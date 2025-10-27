import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';

class StatsController extends GetxController {
  var weeklyPrayerData = <double>[0.8, 1.0, 0.9, 0.7, 1.0, 0.85, 0.95].obs;
  var habitCompletionRates = <Map<String, dynamic>>[
    {'name': 'Tahajud', 'rate': 0.70, 'color': AppColors.primary},
    {'name': 'Quran Reading', 'rate': 0.95, 'color': AppColors.green},
    {'name': 'Fasting', 'rate': 0.85, 'color': AppColors.purple},
    {'name': 'Sedekah', 'rate': 0.92, 'color': AppColors.red},
  ].obs;

  var totalPrayers = 142.obs;
  var onTimeRate = 96.obs;
  var currentStreak = 28.obs;
  var totalDzikir = 1247.obs;
}

class StatsScreen extends StatelessWidget {
  final StatsController controller = Get.put(StatsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildSummaryCards(),
              _buildWeeklyChart(),
              _buildHabitProgress(),
              _buildMonthlyOverview(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Your Statistics',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.green.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text('📈 This Month',
                style: TextStyle(fontSize: 12, color: AppColors.green)),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Obx(() => Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 1.5,
            children: [
              _buildSummaryCard('${controller.totalPrayers}', 'Total Prayers',
                  AppColors.purple, Icons.mosque),
              _buildSummaryCard('${controller.onTimeRate}%', 'On-Time Rate',
                  AppColors.green, Icons.check_circle),
              _buildSummaryCard('${controller.currentStreak}', 'Current Streak',
                  AppColors.green, Icons.local_fire_department),
              _buildSummaryCard('${controller.totalDzikir}', 'Total Dzikir',
                  AppColors.red, Icons.auto_awesome),
            ],
          ),
        ));
  }

  Widget _buildSummaryCard(
      String value, String label, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [color, color.withOpacity(0.7)]),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: Colors.white70, size: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              Text(label,
                  style: TextStyle(fontSize: 12, color: Colors.white70)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyChart() {
    return Obx(() => Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Weekly Prayer Performance',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(7, (index) {
                  final days = [
                    'Mon',
                    'Tue',
                    'Wed',
                    'Thu',
                    'Fri',
                    'Sat',
                    'Sun'
                  ];
                  return Column(
                    children: [
                      Container(
                        width: 30,
                        height: 150 * controller.weeklyPrayerData[index],
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [AppColors.primary, AppColors.green],
                          ),
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(10)),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(days[index],
                          style: TextStyle(fontSize: 10, color: Colors.grey)),
                    ],
                  );
                }),
              ),
            ],
          ),
        ));
  }

  Widget _buildHabitProgress() {
    return Obx(() => Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Habit Completion Rate',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              ...controller.habitCompletionRates
                  .map((habit) => Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(habit['name'],
                                  style: TextStyle(fontSize: 14)),
                              Text('${(habit['rate'] * 100).toInt()}%',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: habit['color'])),
                            ],
                          ),
                          SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: habit['rate'],
                              minHeight: 8,
                              backgroundColor: Colors.grey[800],
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(habit['color']),
                            ),
                          ),
                          SizedBox(height: 15),
                        ],
                      ))
                  .toList(),
            ],
          ),
        ));
  }

  Widget _buildMonthlyOverview() {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Monthly Overview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 2,
            children: [
              _buildOverviewItem('25', 'Days Active', AppColors.primary),
              _buildOverviewItem('120', 'Prayers', AppColors.green),
              _buildOverviewItem('45', 'Juz Read', AppColors.purple),
              _buildOverviewItem('8', 'Fasting Days', AppColors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewItem(String value, String label, Color color) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(value,
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: color)),
          Text(label, style: TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      ),
    );
  }
}
