import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/habit_model.dart';

class HabitController extends GetxController {
  final habitBox = Hive.box('habits');

  var habits = <Habit>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadHabits();
  }

  void loadHabits() {
    habits.value = [
      Habit(id: '1', name: 'Tahajud', icon: '🌙', streak: 7),
      Habit(
          id: '2',
          name: 'Puasa Senin-Kamis',
          icon: '☀️',
          streak: 12,
          isCompleted: true),
      Habit(id: '3', name: 'Baca Al-Quran', icon: '📖', streak: 30),
      Habit(
          id: '4', name: 'Sedekah', icon: '❤️', streak: 15, isCompleted: true),
    ];
  }

  void toggleHabit(int index) {
    habits[index].isCompleted = !habits[index].isCompleted;
    habits.refresh();
    saveHabits();
  }

  void saveHabits() {
    habitBox.put('habits', habits.map((h) => h.toJson()).toList());
  }
}
