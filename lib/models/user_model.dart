class User {
  final String uid;
  final String email;
  final String name;
  final String? photoUrl;
  final DateTime createdAt;
  final DateTime lastLogin;

  User({
    required this.uid,
    required this.email,
    required this.name,
    this.photoUrl,
    required this.createdAt,
    required this.lastLogin,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        uid: json['uid'] as String,
        email: json['email'] as String,
        name: json['name'] as String,
        photoUrl: json['photoUrl'] as String?,
        createdAt: DateTime.parse(json['createdAt'] as String),
        lastLogin: DateTime.parse(json['lastLogin'] as String),
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'name': name,
        'photoUrl': photoUrl,
        'createdAt': createdAt.toIso8601String(),
        'lastLogin': lastLogin.toIso8601String(),
      };

  User copyWith({
    String? uid,
    String? email,
    String? name,
    String? photoUrl,
    DateTime? createdAt,
    DateTime? lastLogin,
  }) =>
      User(
        uid: uid ?? this.uid,
        email: email ?? this.email,
        name: name ?? this.name,
        photoUrl: photoUrl ?? this.photoUrl,
        createdAt: createdAt ?? this.createdAt,
        lastLogin: lastLogin ?? this.lastLogin,
      );
}
