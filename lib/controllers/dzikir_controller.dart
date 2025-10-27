import 'package:get/get.dart';
import 'package:flutter/services.dart';

class DzikirController extends GetxController {
  var count = 0.obs;
  var target = 33.obs;

  var currentDzikir =
      {'name': 'SubhanAllah', 'arabic': 'سُبْحَانَ اللّٰهِ', 'target': 33}.obs;

  void increment() {
    if (count.value < target.value) {
      count.value++;
      HapticFeedback.lightImpact();

      if (count.value == target.value) {
        HapticFeedback.heavyImpact();
      }
    }
  }

  void reset() {
    count.value = 0;
  }

  void selectDzikir(String name, String arabic, int newTarget) {
    currentDzikir.value = {'name': name, 'arabic': arabic, 'target': newTarget};
    target.value = newTarget;
    count.value = 0;
  }
}
