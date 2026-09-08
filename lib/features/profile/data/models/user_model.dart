import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String uid;
  final String name;
  final String email;
  final DateTime? createdAt;
  final String themeMode;

  const UserProfile({
    required this.uid,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.themeMode,
  });

  factory UserProfile.fromJson(
    Map<String, dynamic> json, {
    required String uid,
  }) {
    final createdAt = json['createdAt'];

    return UserProfile(
      uid: uid,
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      createdAt: createdAt is Timestamp
          ? createdAt.toDate()
          : null,
      themeMode: json['themeMode'] as String? ?? 'system',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'createdAt': createdAt == null
          ? null
          : Timestamp.fromDate(createdAt!),
      'themeMode': themeMode,
    };
  }
}