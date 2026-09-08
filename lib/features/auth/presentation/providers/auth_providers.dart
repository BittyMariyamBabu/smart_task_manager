import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/features/auth/data/models/auth_model.dart';
import 'package:task_manager/features/auth/data/repositories/auth_repository.dart';

/// A provider for the FirebaseFirestore instance.
final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

/// A provider for the FirebaseAuth instance.
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

/// Provides the currently authenticated Firebase user.
final currentFirebaseUserProvider = Provider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).currentUser;
});

/// A provider for the AuthRepository instance.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    ref.watch(firebaseAuthProvider),
    ref.watch(firebaseFirestoreProvider),
  );
});

//// A provider that exposes the current authentication state of the user.
final authStateProvider = StreamProvider<AuthUser?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
});

/// A provider for the AuthController instance, which manages authentication state and actions.
final authControllerProvider =
    AsyncNotifierProvider<AuthController, void>(
  AuthController.new,
);


/// A controller class that manages authentication state and actions.
///
/// This class extends [AsyncNotifier] to provide asynchronous state management for authentication operations.
class AuthController extends AsyncNotifier<void> {
  late final AuthRepository _repository;

  /// Initializes the AuthController by reading the AuthRepository from the provider.
  @override
  void build() {
    _repository = ref.read(authRepositoryProvider);
  }
  
  /// Logs in a user with the provided email and password.
  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    
    // Guard the login operation to handle errors and update the state accordingly.
    state = await AsyncValue.guard(() {
      return _repository.login(
        email: email,
        password: password,
      );
    });
  }

  /// Registers a new user with the provided email and password.
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    
    // Guard the registration operation to handle errors and update the state accordingly.
    state = await AsyncValue.guard(() {
      return _repository.register(
        name: name,
        email: email,
        password: password,
      );
    });
  }
  
  /// Logs out the currently authenticated user.
  Future<void> logout() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() {
      return _repository.logout();
    });
  }
}