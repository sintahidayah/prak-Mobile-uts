import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../constants/colors.dart';

class ThemeController extends GetxController {
  final themeBox = Hive.box('settings');

  var isDarkMode = true.obs;
  var primaryColor = Color(0xFF2D5F5D).obs;
  var accentColor = Color(0xFFFFD700).obs;

  final List<Map<String, dynamic>> themePresets = [
    {
      'name': 'Teal (Default)',
      'primary': Color(0xFF2D5F5D),
      'accent': Color(0xFFFFD700)
    },
    {
      'name': 'Ocean Blue',
      'primary': Color(0xFF006994),
      'accent': Color(0xFF4FC3F7)
    },
    {
      'name': 'Forest Green',
      'primary': Color(0xFF2E7D32),
      'accent': Color(0xFF81C784)
    },
    {
      'name': 'Royal Purple',
      'primary': Color(0xFF6A1B9A),
      'accent': Color(0xFFBA68C8)
    },
    {
      'name': 'Sunset Orange',
      'primary': Color(0xFFE65100),
      'accent': Color(0xFFFFB74D)
    },
  ];

  @override
  void onInit() {
    super.onInit();
    loadTheme();
  }

  void loadTheme() {
    isDarkMode.value = themeBox.get('isDarkMode', defaultValue: true);
    final savedPrimary = themeBox.get('primaryColor');
    final savedAccent = themeBox.get('accentColor');

    if (savedPrimary != null) primaryColor.value = Color(savedPrimary);
    if (savedAccent != null) accentColor.value = Color(savedAccent);

    applyTheme();
  }

  void toggleDarkMode() {
    isDarkMode.value = !isDarkMode.value;
    themeBox.put('isDarkMode', isDarkMode.value);
    applyTheme();
  }

  void changePrimaryColor(Color color) {
    primaryColor.value = color;
    themeBox.put('primaryColor', color.value);
    applyTheme();
  }

  void changeAccentColor(Color color) {
    accentColor.value = color;
    themeBox.put('accentColor', color.value);
    applyTheme();
  }

  void applyThemePreset(int index) {
    final preset = themePresets[index];
    primaryColor.value = preset['primary'];
    accentColor.value = preset['accent'];
    themeBox.put('primaryColor', primaryColor.value.value);
    themeBox.put('accentColor', accentColor.value.value);
    applyTheme();
  }

  void applyTheme() {
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    Get.changeTheme(
      isDarkMode.value
          ? ThemeData.dark().copyWith(
              scaffoldBackgroundColor: Color(0xFF0A0E21),
              primaryColor: primaryColor.value,
              colorScheme: ColorScheme.dark(
                primary: primaryColor.value,
                secondary: accentColor.value,
              ),
            )
          : ThemeData.light().copyWith(
              scaffoldBackgroundColor: Colors.white,
              primaryColor: primaryColor.value,
              colorScheme: ColorScheme.light(
                primary: primaryColor.value,
                secondary: accentColor.value,
              ),
            ),
    );
  }
}

// Theme Settings Screen
class ThemeSettingsScreen extends StatelessWidget {
  final ThemeController controller = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Settings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => SwitchListTile(
                  title: Text('Dark Mode'),
                  subtitle: Text('Enable dark theme'),
                  value: controller.isDarkMode.value,
                  activeColor: controller.primaryColor.value,
                  onChanged: (_) => controller.toggleDarkMode(),
                )),
            SizedBox(height: 30),
            Text('Theme Presets',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 15),
            ...List.generate(controller.themePresets.length, (index) {
              final preset = controller.themePresets[index];
              return GestureDetector(
                onTap: () => controller.applyThemePreset(index),
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [preset['primary'], preset['accent']],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      SizedBox(width: 15),
                      Text(preset['name']),
                    ],
                  ),
                ),
              );
            }),
            SizedBox(height: 30),
            Text('Custom Colors',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 15),
            Obx(() => _buildColorPicker(
                'Primary Color',
                controller.primaryColor.value,
                (color) => controller.changePrimaryColor(color))),
            SizedBox(height: 15),
            Obx(() => _buildColorPicker(
                'Accent Color',
                controller.accentColor.value,
                (color) => controller.changeAccentColor(color))),
          ],
        ),
      ),
    );
  }

  Widget _buildColorPicker(
      String label, Color currentColor, Function(Color) onColorChanged) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          GestureDetector(
            onTap: () {
              // Show color picker dialog
              Get.defaultDialog(
                title: 'Pick $label',
                content: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    Color(0xFF2D5F5D),
                    Color(0xFF006994),
                    Color(0xFF2E7D32),
                    Color(0xFF6A1B9A),
                    Color(0xFFE65100),
                    Color(0xFFD32F2F),
                    Color(0xFF303F9F),
                    Color(0xFF00796B),
                    Color(0xFFF57C00),
                  ]
                      .map((color) => GestureDetector(
                            onTap: () {
                              onColorChanged(color);
                              Get.back();
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 2),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              );
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: currentColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
