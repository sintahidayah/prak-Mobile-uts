import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  final _user = Rxn<User>();
  final _isLoading = false.obs;
  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  bool get isAuthenticated => _user.value != null;
  bool get isLoading => _isLoading.value;
  User? get user => _user.value;

  @override
  void onInit() {
    super.onInit();
    _loadUserFromStorage();
  }

  Future<void> _loadUserFromStorage() async {
    _isLoading.value = true;
    try {
      final prefs = await _prefs;
      final userJson = prefs.getString('user');
      if (userJson != null) {
        Map<String, dynamic> jsonMap = Map<String, dynamic>.from(
          prefs.getString('user')?.split(',').fold<Map<String, dynamic>>({},
                  (map, item) {
                final parts = item.split(':');
                if (parts.length == 2) {
                  map[parts[0].trim().replaceAll('{', '')] =
                      parts[1].trim().replaceAll('}', '');
                }
                return map;
              }) ??
              {},
        );
        _user.value = User.fromJson(jsonMap);
      }
    } catch (e) {
      print('Error loading user: \$e');
      _user.value = null;
    } finally {
      _isLoading.value = false;
    }
  }

  Future<bool> login(String email, String password) async {
    _isLoading.value = true;
    try {
      // TODO: Implement actual authentication logic here
      // For demo, we'll just create a mock user
      if (email == 'demo@example.com' && password == 'password123') {
        final user = User(
          uid: 'mock-uid-123',
          email: email,
          name: 'Demo User',
          createdAt: DateTime.now(),
          lastLogin: DateTime.now(),
        );

        await _saveUser(user);
        _user.value = user;
        Get.offAllNamed('/home');
        return true;
      }
      Get.snackbar(
        'Error',
        'Invalid email or password',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Login failed: \${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> logout() async {
    _isLoading.value = true;
    try {
      final prefs = await _prefs;
      await prefs.remove('user');
      _user.value = null;
      Get.offAllNamed('/login');
    } catch (e) {
      print('Error during logout: \$e');
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> _saveUser(User user) async {
    try {
      final prefs = await _prefs;
      final userJson = user.toJson();
      final userString =
          userJson.entries.map((e) => '${e.key}:${e.value}').join(',');
      await prefs.setString('user', '{$userString}');
    } catch (e) {
      print('Error saving user: \$e');
    }
  }
}
