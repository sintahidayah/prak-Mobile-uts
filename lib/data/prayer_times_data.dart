import '../models/prayer_model.dart';

class PrayerTimesData {
  static List<Prayer> getPrayerTimes() {
    return [
      Prayer(name: 'Fajr', time: '04:45', isCompleted: true),
      Prayer(name: 'Dhuhr', time: '12:15', isCompleted: true),
      Prayer(name: 'Asr', time: '15:30', isCompleted: true),
      Prayer(name: 'Maghrib', time: '18:05', isCompleted: false),
      Prayer(name: 'Isha', time: '19:30', isCompleted: false),
    ];
  }
}
