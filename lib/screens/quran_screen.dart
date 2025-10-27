import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/ayah_model.dart';
import '../data/quran_data.dart';
import '../constants/colors.dart';

class QuranController extends GetxController {
  var ayahs = <Ayah>[].obs;
  var currentSurah = <String, dynamic>{
    'number': 1,
    'name': 'Al-Fatihah',
    'translation': 'The Opening',
    'type': 'Makiyah',
    'ayahs': 7
  }.obs;
  var allSurahs = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    allSurahs.value = QuranData.getAllSurahs();
    loadSurah(1);
  }

  void loadSurah(int surahNumber) {
    ayahs.value = QuranData.getSurahByNumber(surahNumber);
    currentSurah.value =
        allSurahs.firstWhere((s) => s['number'] == surahNumber);
  }

  void showSurahSelector() {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.7,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text('Select Surah',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: allSurahs.length,
                itemBuilder: (context, index) {
                  final surah = allSurahs[index];
                  return ListTile(
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(child: Text('${surah['number']}')),
                    ),
                    title: Text(surah['name']),
                    subtitle: Text(
                        '${surah['translation']} • ${surah['ayahs']} Ayat'),
                    trailing: Text(surah['type'],
                        style: TextStyle(fontSize: 12, color: Colors.grey)),
                    onTap: () {
                      loadSurah(surah['number']);
                      Get.back();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuranScreen extends StatelessWidget {
  final QuranController controller = Get.put(QuranController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Obx(() => Container(
                padding: EdgeInsets.fromLTRB(20, 60, 20, 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [AppColors.green, Color(0xFF00856F)]),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () => Get.back()),
                        Spacer(),
                        IconButton(
                            icon: Icon(Icons.bookmark_border),
                            onPressed: () {}),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => controller.showSurahSelector(),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('📋', style: TextStyle(fontSize: 20)),
                            SizedBox(width: 10),
                            Text('Select Surah',
                                style: TextStyle(fontSize: 14)),
                            SizedBox(width: 5),
                            Icon(Icons.arrow_drop_down),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(controller.currentSurah['name'].toString(),
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold)),
                    Text(
                        '${controller.currentSurah['translation']} • ${controller.currentSurah['ayahs']} Ayat',
                        style: TextStyle(color: Colors.white70)),
                  ],
                ),
              )),
          Expanded(
            child: Obx(() => ListView.builder(
                  padding: EdgeInsets.all(20),
                  itemCount: controller.ayahs.length,
                  itemBuilder: (context, index) {
                    final ayah = controller.ayahs[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 15),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text('Ayah ${ayah.number}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      icon: Icon(Icons.play_circle_outline,
                                          size: 20),
                                      onPressed: () {}),
                                  IconButton(
                                      icon: Icon(Icons.share, size: 20),
                                      onPressed: () {}),
                                  IconButton(
                                      icon:
                                          Icon(Icons.bookmark_border, size: 20),
                                      onPressed: () {}),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Text(ayah.arabic,
                              style: TextStyle(fontSize: 24, height: 2),
                              textAlign: TextAlign.right),
                          if (ayah.transliteration.isNotEmpty) ...[
                            SizedBox(height: 10),
                            Text(ayah.transliteration,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic,
                                    color: AppColors.accent)),
                          ],
                          SizedBox(height: 15),
                          Divider(color: Colors.white10),
                          SizedBox(height: 15),
                          Text(ayah.translation,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  height: 1.6)),
                        ],
                      ),
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}
