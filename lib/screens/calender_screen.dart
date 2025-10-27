import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../constants/colors.dart';

class CalendarController extends GetxController {
  var selectedDate = DateTime.now().obs;
  var currentMonth = DateTime.now().obs;
  var prayerCompletion = <String, List<bool>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadPrayerData();
  }

  void loadPrayerData() {
    // Generate dummy data untuk bulan ini
    final daysInMonth =
        DateTime(currentMonth.value.year, currentMonth.value.month + 1, 0).day;
    for (int i = 1; i <= daysInMonth; i++) {
      final dateKey =
          '${currentMonth.value.year}-${currentMonth.value.month}-$i';
      // Random completion: 5 prayers per day, some completed some not
      prayerCompletion[dateKey] = List.generate(
          5, (index) => i < DateTime.now().day ? (index < 4) : false);
    }
  }

  void previousMonth() {
    currentMonth.value =
        DateTime(currentMonth.value.year, currentMonth.value.month - 1);
    loadPrayerData();
  }

  void nextMonth() {
    currentMonth.value =
        DateTime(currentMonth.value.year, currentMonth.value.month + 1);
    loadPrayerData();
  }

  int getCompletedPrayers(int day) {
    final dateKey =
        '${currentMonth.value.year}-${currentMonth.value.month}-$day';
    return prayerCompletion[dateKey]?.where((p) => p).length ?? 0;
  }
}

class CalendarScreen extends StatelessWidget {
  final CalendarController controller = Get.put(CalendarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildMonthNavigator(),
            _buildWeekDays(),
            _buildCalendarGrid(),
            _buildLegend(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Prayer Calendar',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text('📅 ${DateFormat('MMM yyyy').format(DateTime.now())}',
                style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthNavigator() {
    return Obx(() => Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.chevron_left),
                onPressed: () => controller.previousMonth(),
              ),
              Column(
                children: [
                  Text(
                    DateFormat('MMMM yyyy')
                        .format(controller.currentMonth.value),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Rabi\' al-Thani 1447',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(Icons.chevron_right),
                onPressed: () => controller.nextMonth(),
              ),
            ],
          ),
        ));
  }

  Widget _buildWeekDays() {
    final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: days
            .map((day) => Container(
                  width: 40,
                  child: Text(day,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    return Expanded(
      child: Obx(() {
        final daysInMonth = DateTime(controller.currentMonth.value.year,
                controller.currentMonth.value.month + 1, 0)
            .day;
        final firstDayOfMonth = DateTime(controller.currentMonth.value.year,
                controller.currentMonth.value.month, 1)
            .weekday;

        return GridView.builder(
          padding: EdgeInsets.all(20),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 0.8,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: daysInMonth + (firstDayOfMonth % 7),
          itemBuilder: (context, index) {
            if (index < (firstDayOfMonth % 7)) {
              return Container();
            }

            final day = index - (firstDayOfMonth % 7) + 1;
            final isToday = day == DateTime.now().day &&
                controller.currentMonth.value.month == DateTime.now().month;
            final completedCount = controller.getCompletedPrayers(day);

            return GestureDetector(
              onTap: () => controller.selectedDate.value = DateTime(
                controller.currentMonth.value.year,
                controller.currentMonth.value.month,
                day,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: isToday ? AppColors.primary : AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('$day',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          5,
                          (i) => Container(
                                width: 4,
                                height: 4,
                                margin: EdgeInsets.symmetric(horizontal: 1),
                                decoration: BoxDecoration(
                                  color: i < completedCount
                                      ? AppColors.green
                                      : Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                              )),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildLegend() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildLegendItem('✓ Completed', AppColors.green),
          _buildLegendItem('○ Missed', Colors.grey),
          _buildLegendItem('● Today', AppColors.primary),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        SizedBox(width: 5),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
