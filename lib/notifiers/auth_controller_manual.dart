/// AsyncNotifier example (without codegen)
import 'dart:async';

import 'package:async_notifier_example_riverpod/repositories/fake_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() async {
    // return a value (or do nothing if the return type is void)
    await Future.delayed(Duration(milliseconds: 1000));
  }

  Future<void> signInAnonymously() async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(authRepository.signInAnonymously);
  }

  Future<void> signOut() async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(authRepository.signOut);
  }
}

final authControllerProvider =
    AsyncNotifierProvider<AuthController, void>(AuthController.new);
