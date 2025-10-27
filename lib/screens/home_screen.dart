import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/prayer_controller.dart';
import '../controllers/habit_controller.dart';
import '../widgets/prayer_card.dart';
import '../widgets/habit_card.dart';
import '../widgets/quick_action_card.dart';
import '../widgets/stats_card.dart';
import '../constants/colors.dart';
import '../constants/text_styles.dart';
import 'dzikir_screen.dart';
import 'qibla_screen.dart';
import 'quran_screen.dart';
import 'dua_screen.dart';

class HomeScreen extends StatelessWidget {
  final PrayerController prayerController = Get.put(PrayerController());
  final HabitController habitController = Get.put(HabitController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              PrayerCard(),
              _buildPrayerTimesList(),
              _buildQuickActions(),
              _buildHabits(),
              StatsCard(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.primary.withOpacity(0.1), Colors.transparent],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Assalamu\'alaikum', style: AppTextStyles.caption),
              SizedBox(height: 5),
              Text('Ahmad Fadhil', style: AppTextStyles.heading2),
            ],
          ),
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, Color(0xFF3D7F7D)],
                  ),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: () {},
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text('3',
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPrayerTimesList() {
    return Obx(() => Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: prayerController.prayers.asMap().entries.map((entry) {
              final index = entry.key;
              final prayer = entry.value;
              final isActive = prayer.name == prayerController.nextPrayer.value;

              return GestureDetector(
                onTap: () => prayerController.togglePrayer(index),
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color:
                        isActive ? AppColors.primary : AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(prayer.name,
                          style: AppTextStyles.body
                              .copyWith(fontWeight: FontWeight.w600)),
                      Row(
                        children: [
                          Text(
                            prayer.time,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.accent,
                            ),
                          ),
                          SizedBox(width: 15),
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white30, width: 2),
                              borderRadius: BorderRadius.circular(12),
                              color: prayer.isCompleted
                                  ? AppColors.green
                                  : Colors.transparent,
                            ),
                            child: prayer.isCompleted
                                ? Icon(Icons.check,
                                    size: 16, color: Colors.white)
                                : null,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ));
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Quick Actions', style: AppTextStyles.heading2),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              QuickActionCard(
                title: 'Dzikir',
                icon: '🧠',
                color: AppColors.purple,
                onTap: () => Get.to(() => DzikirScreen()),
              ),
              QuickActionCard(
                title: 'Qibla',
                icon: '🧭',
                color: AppColors.red,
                onTap: () => Get.to(() => QiblaScreen()),
              ),
              QuickActionCard(
                title: 'Quran',
                icon: '📖',
                color: AppColors.green,
                onTap: () => Get.to(() => QuranScreen()),
              ),
              QuickActionCard(
                title: 'Dua',
                icon: '❤️',
                color: AppColors.pink,
                onTap: () => Get.to(() => DuaScreen()),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHabits() {
    return Obx(() => Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Today\'s Habits', style: AppTextStyles.heading2),
                  Text('See All', style: TextStyle(color: AppColors.primary)),
                ],
              ),
              SizedBox(height: 15),
              ...habitController.habits.asMap().entries.map((entry) {
                return HabitCard(
                  habit: entry.value,
                  onTap: () => habitController.toggleHabit(entry.key),
                );
              }).toList(),
            ],
          ),
        ));
  }
}
