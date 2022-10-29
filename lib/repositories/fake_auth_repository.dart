// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../notifiers/counter_manual.dart';

class AuthException implements Exception {
  String? message;
  AuthException({
    this.message,
  });
}

/// A fake repository class to be used by the notifiers
class FakeAuthRepository {
  FakeAuthRepository({this.inhibitLogin = false}) {
    _authStateController.add(false);
    print('inhibitLogin: $inhibitLogin');
  }
  final bool inhibitLogin;
  final _authStateController = StreamController<bool>();
  Stream<bool> authStateChanges() => _authStateController.stream;

  Future<void> signInAnonymously() async {
    await Future.delayed(const Duration(seconds: 2));
    if (inhibitLogin) {
      throw AuthException(message: 'inhibitLogin is true');
    }
    _authStateController.add(true);
  }

  Future<void> signOut() async {
    await Future.delayed(const Duration(seconds: 2));
    _authStateController.add(false);
  }

  void dispose() => _authStateController.close();
}

final authRepositoryProvider = Provider<FakeAuthRepository>((ref) {
  final counterIsOdd = ref.watch(counterProvider).isOdd;
  print('counterIsOdd: $counterIsOdd');
  final auth = FakeAuthRepository(inhibitLogin: counterIsOdd);
  ref.onDispose(() => auth.dispose());
  return auth;
});

final authStateChangesProvider = StreamProvider<bool>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});
