import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/prayer_model.dart';
import '../data/prayer_times_data.dart';

class PrayerController extends GetxController {
  final prayerBox = Hive.box('prayers');

  var prayers = <Prayer>[].obs;
  var nextPrayer = 'Maghrib'.obs;
  var timeUntilNext = '2:34:12'.obs;

  @override
  void onInit() {
    super.onInit();
    loadPrayers();
  }

  void loadPrayers() {
    prayers.value = PrayerTimesData.getPrayerTimes();
    updateNextPrayer();
  }

  void updateNextPrayer() {
    // Logic untuk menentukan sholat berikutnya
    for (var prayer in prayers) {
      if (!prayer.isCompleted) {
        nextPrayer.value = prayer.name;
        break;
      }
    }
  }

  void togglePrayer(int index) {
    prayers[index].isCompleted = !prayers[index].isCompleted;
    prayers.refresh();
    updateNextPrayer();
    savePrayers();
  }

  void savePrayers() {
    prayerBox.put('prayers', prayers.map((p) => p.toJson()).toList());
  }
}
