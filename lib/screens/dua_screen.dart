import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dua_controller.dart';
import '../constants/colors.dart';

class DuaScreen extends StatelessWidget {
  final DuaController controller = Get.put(DuaController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(20, 60, 20, 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.pink, AppColors.red],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => Get.back(),
                    ),
                    Spacer(),
                  ],
                ),
                Text(
                  'Daily Du\'as',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Essential Supplications',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          Container(
            height: 50,
            child: Obx(() => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: controller.categories.length,
                  itemBuilder: (context, index) {
                    final category = controller.categories[index];
                    final isSelected =
                        controller.selectedCategory.value == category;
                    return GestureDetector(
                      onTap: () => controller.filterByCategory(category),
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.pink
                              : AppColors.pink.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.pink.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  },
                )),
          ),
          Expanded(
            child: Obx(() => ListView.builder(
                  padding: EdgeInsets.all(20),
                  itemCount: controller.filteredDuas.length,
                  itemBuilder: (context, index) {
                    final dua = controller.filteredDuas[index];
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
                              Text(
                                dua.title,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => controller.toggleFavorite(dua.id),
                                child: Text(
                                  dua.isFavorite ? '⭐' : '☆',
                                  style: TextStyle(fontSize: 24),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              dua.arabic,
                              style: TextStyle(fontSize: 22, height: 2),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.accent.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColors.accent.withOpacity(0.3),
                              ),
                            ),
                            child: Text(
                              dua.transliteration,
                              style: TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                color: AppColors.accent,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            dua.translation,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              height: 1.6,
                            ),
                          ),
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
