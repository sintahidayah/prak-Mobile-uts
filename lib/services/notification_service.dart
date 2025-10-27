import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    await _notifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        // Handle notification tap
      },
    );

    tz.initializeTimeZones();
  }

  Future<void> schedulePrayerNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    await _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'prayer_channel',
          'Prayer Notifications',
          channelDescription: 'Notifications for prayer times',
          importance: Importance.high,
          priority: Priority.high,
          sound: RawResourceAndroidNotificationSound('adzan'),
        ),
        iOS: DarwinNotificationDetails(
          sound: 'adzan.mp3',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> scheduleAllPrayerNotifications() async {
    final prayers = {
      1: {'name': 'Fajr', 'time': DateTime.now().add(Duration(hours: 1))},
      2: {'name': 'Dhuhr', 'time': DateTime.now().add(Duration(hours: 3))},
      3: {'name': 'Asr', 'time': DateTime.now().add(Duration(hours: 5))},
      4: {'name': 'Maghrib', 'time': DateTime.now().add(Duration(hours: 7))},
      5: {'name': 'Isha', 'time': DateTime.now().add(Duration(hours: 9))},
    };

    for (var entry in prayers.entries) {
      await schedulePrayerNotification(
        id: entry.key,
        title: '🕌 ${entry.value['name']} Prayer Time',
        body: 'It\'s time for ${entry.value['name']} prayer',
        scheduledTime: entry.value['time'] as DateTime,
      );
    }
  }

  Future<void> showInstantNotification({
    required String title,
    required String body,
  }) async {
    await _notifications.show(
      0,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'instant_channel',
          'Instant Notifications',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }
}
