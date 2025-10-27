import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../controllers/auth_controller.dart';

class ProfileScreen extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final _isDarkMode = true.obs;
  final _notificationsEnabled = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildProfileHeader(),
              _buildStatsSection(),
              _buildSettingsSection(),
              _buildDataSection(),
              _buildAboutSection(),
              SizedBox(height: 20),
              _buildLogoutButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Obx(() => Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [AppColors.primary, AppColors.green]),
                      shape: BoxShape.circle,
                    ),
                    child: authController.user?.photoUrl != null
                        ? ClipOval(
                            child: Image.network(
                              authController.user!.photoUrl!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.green,
                        shape: BoxShape.circle,
                      ),
                      child:
                          Icon(Icons.camera_alt, size: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                authController.user?.name ?? 'Guest User',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                authController.user?.email ?? 'guest@example.com',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ));
  }

  Widget _buildStatsSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _buildStatItem('Days Active', '28'),
          _buildStatItem('Total Prayers', '142'),
          _buildStatItem('On-time Rate', '96%'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Text(value,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary)),
            SizedBox(height: 5),
            Text(label,
                style: TextStyle(fontSize: 12, color: Colors.grey),
                textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 15),
          Obx(() =>
              _buildSettingItem(Icons.dark_mode, 'Dark Mode', true, (val) {
                _isDarkMode.value = val;
                Get.changeThemeMode(val ? ThemeMode.dark : ThemeMode.light);
              })),
          Obx(() => _buildSettingItem(Icons.notifications, 'Notifications',
              true, (val) => _notificationsEnabled.value = val)),
          _buildSettingItem(Icons.language, 'Language', false, null,
              trailing: 'English'),
        ],
      ),
    );
  }

  Widget _buildSettingItem(
      IconData icon, String title, bool isSwitch, Function(bool)? onChanged,
      {String? trailing}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          SizedBox(width: 15),
          Text(title),
          Spacer(),
          if (isSwitch)
            Obx(() => Switch(
                  value: title == 'Dark Mode'
                      ? _isDarkMode.value
                      : _notificationsEnabled.value,
                  onChanged: onChanged,
                  activeColor: AppColors.primary,
                ))
          else if (trailing != null)
            Row(
              children: [
                Text(trailing, style: TextStyle(color: Colors.grey)),
                SizedBox(width: 5),
                Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildDataSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Data Management',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 15),
          _buildDataItem(Icons.upload, 'Export Data', () {
            Get.snackbar(
              'Export',
              'Data exported successfully',
              snackPosition: SnackPosition.BOTTOM,
            );
          }),
          _buildDataItem(Icons.download, 'Import Data', () {
            Get.snackbar(
              'Import',
              'Data imported successfully',
              snackPosition: SnackPosition.BOTTOM,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDataItem(IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.primary),
            SizedBox(width: 15),
            Text(title),
            Spacer(),
            Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('About',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 15),
          _buildAboutItem(Icons.info, 'Version', '1.0.0'),
          _buildAboutItem(Icons.phone, 'Contact Support', 'Get Help'),
          _buildAboutItem(Icons.description, 'Terms of Service', 'Read'),
          _buildAboutItem(Icons.privacy_tip, 'Privacy Policy', 'Read'),
        ],
      ),
    );
  }

  Widget _buildAboutItem(IconData icon, String title, String info) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          SizedBox(width: 15),
          Text(title),
          Spacer(),
          Text(info, style: TextStyle(color: Colors.grey)),
          SizedBox(width: 5),
          Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: () => _showLogoutDialog(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: Text(
            'Logout',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    Get.defaultDialog(
      title: 'Logout',
      middleText: 'Are you sure you want to logout?',
      textConfirm: 'Yes',
      textCancel: 'No',
      confirmTextColor: Colors.white,
      onConfirm: () {
        authController.logout();
        Get.back();
      },
    );
  }
}
