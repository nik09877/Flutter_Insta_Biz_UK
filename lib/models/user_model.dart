class User {
  String name;
  int mobileNumber;
  int userId;
  String password;
  int mpin;
  bool fingerprint;
  DateTime lastVisited;

  User({
    required this.name,
    required this.mobileNumber,
    required this.userId,
    required this.password,
    required this.mpin,
    required this.fingerprint,
    required this.lastVisited,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      mobileNumber: json['mobile_number'],
      userId: json['user_id'],
      password: json['password'],
      mpin: json['mpin'],
      fingerprint: json['fingerprint'],
      lastVisited: DateTime.parse(json['last_visited']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'mobile_number': mobileNumber,
      'user_id': userId,
      'password': password,
      'mpin': mpin,
      'fingerprint': fingerprint,
      'last_visited': lastVisited.toIso8601String(),
    };
  }
}
