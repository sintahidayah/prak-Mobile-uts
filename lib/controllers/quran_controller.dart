import 'package:get/get.dart';
import '../models/ayah_model.dart';
import '../data/quran_data.dart';

class QuranController extends GetxController {
  var ayahs = <Ayah>[].obs;
  var currentSurah = 'Al-Fatihah'.obs;

  @override
  void onInit() {
    super.onInit();
    loadSurah();
  }

  void loadSurah() {
    ayahs.value = QuranData.getAlFatihah();
  }
}
