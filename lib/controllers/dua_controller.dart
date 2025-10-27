import 'package:get/get.dart';
import '../models/dua_model.dart';
import '../data/dua_data.dart';

class DuaController extends GetxController {
  var allDuas = <Dua>[].obs;
  var filteredDuas = <Dua>[].obs;
  var selectedCategory = 'All'.obs;
  var categories = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDuas();
  }

  void loadDuas() {
    allDuas.value = DuaData.getAllDuas();
    filteredDuas.value = allDuas;
    categories.value = DuaData.getCategories();
  }

  void filterByCategory(String category) {
    selectedCategory.value = category;
    if (category == 'All') {
      filteredDuas.value = allDuas;
    } else {
      filteredDuas.value =
          allDuas.where((dua) => dua.category == category).toList();
    }
  }

  void toggleFavorite(String id) {
    final duaIndex = allDuas.indexWhere((d) => d.id == id);
    if (duaIndex != -1) {
      allDuas[duaIndex].isFavorite = !allDuas[duaIndex].isFavorite;
      allDuas.refresh();
      filterByCategory(selectedCategory.value);
    }
  }
}
