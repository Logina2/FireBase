class AppUser {
  final String name;
  final String profilePic;
  final String token;
  final String email;
  final String uid;

  AppUser({
    required this.name,
    required this.profilePic,
    required this.token,
    required this.email,
    required this.uid,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profilePic': profilePic,
      'token': token,
      'email': email,
      'uid': uid,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      name: map['name'] ?? '',
      profilePic: map['profilePic'] ?? '',
      token: map['token'] ?? '',
      email: map['email'] ?? '',
      uid: map['uid'] ?? '',
    );
  }
}
