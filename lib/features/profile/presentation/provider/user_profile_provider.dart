import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/features/auth/presentation/providers/auth_providers.dart';
import 'package:task_manager/features/profile/data/models/user_model.dart';
import 'package:task_manager/features/profile/data/repositories/user_repository.dart';

/// A provider for the UserProfileRepository, which is responsible for fetching user profile data from Firestore.
final userProfileRepositoryProvider = Provider<UserProfileRepository>((ref) {
  return UserProfileRepository(
    ref.watch(firebaseFirestoreProvider),
  );
});

/// A FutureProvider that fetches the current user's profile from Firestore.
final currentUserProfileProvider = FutureProvider<UserProfile?>((ref) async {
  final authUser = await ref.watch(
    authStateProvider.future,
  );

  if (authUser == null) {
    return null;
  }

  return ref
      .read(userProfileRepositoryProvider)
      .getUserProfile(authUser.uid);
});