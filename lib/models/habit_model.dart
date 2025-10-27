class Habit {
  final String id;
  final String name;
  final String icon;
  int streak;
  bool isCompleted;

  Habit({
    required this.id,
    required this.name,
    required this.icon,
    this.streak = 0,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'icon': icon,
        'streak': streak,
        'isCompleted': isCompleted,
      };

  factory Habit.fromJson(Map<String, dynamic> json) => Habit(
        id: json['id'],
        name: json['name'],
        icon: json['icon'],
        streak: json['streak'] ?? 0,
        isCompleted: json['isCompleted'] ?? false,
      );
}
