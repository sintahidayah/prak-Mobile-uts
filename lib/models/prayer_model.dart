class Prayer {
  final String name;
  final String time;
  bool isCompleted;

  Prayer({
    required this.name,
    required this.time,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'time': time,
        'isCompleted': isCompleted,
      };

  factory Prayer.fromJson(Map<String, dynamic> json) => Prayer(
        name: json['name'],
        time: json['time'],
        isCompleted: json['isCompleted'] ?? false,
      );
}
