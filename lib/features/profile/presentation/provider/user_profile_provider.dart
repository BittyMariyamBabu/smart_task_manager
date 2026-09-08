import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/features/auth/presentation/providers/auth_providers.dart';
import 'package:task_manager/features/profile/data/models/user_model.dart';
import 'package:task_manager/features/profile/data/repositories/user_repository.dart';

/// A provider for the UserProfileRepository, which is responsible
/// for fetching and updating user profile data from Firestore.
final userProfileRepositoryProvider =
    Provider<UserProfileRepository>((ref) {
  return UserProfileRepository(
    ref.watch(firebaseFirestoreProvider),
  );
});

/// A FutureProvider that fetches the current user's profile from Firestore.
final currentUserProfileProvider =
    FutureProvider<UserProfile?>((ref) async {
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

/// A provider for the UserProfileController, which manages
/// the state of the user's profile.
final userProfileControllerProvider =
    AsyncNotifierProvider<UserProfileController, void>(
  UserProfileController.new,
);

/// A controller that manages the state of the user's profile,
/// including updating the profile and theme preference.
class UserProfileController extends AsyncNotifier<void> {
  late final _repository =
      ref.read(userProfileRepositoryProvider);

  @override
  void build() {}

  /// Updates the user's profile information in Firestore
  /// and refreshes the profile data.
  Future<void> updateProfile({
    required String uid,
    required String email,
    required String name,
  }) async {
    state = const AsyncLoading();

    try {
      await _repository.updateProfile(
        uid: uid,
        name: name,
        email: email,
      );

      // Refresh the profile after Firestore update.
      ref.invalidate(currentUserProfileProvider);

      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }

  /// Updates the user's theme preference in Firestore
  /// and refreshes the profile.
  Future<void> updateTheme({
    required String uid,
    required String themeMode,
  }) async {
    state = const AsyncLoading();

    try {
      await _repository.updateThemeMode(
        uid: uid,
        themeMode: themeMode,
      );

      // Refresh the profile after Firestore update.
      ref.invalidate(currentUserProfileProvider);

      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}