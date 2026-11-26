
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final splashViewModelProvider =
    NotifierProvider<SplashViewModel, bool>(
  SplashViewModel.new,
);

class SplashViewModel extends Notifier<bool> {
  @override
  bool build() => false;

  Future<void> start() async {
    await Future.delayed(const Duration(seconds: 3));
    state = true;
  }
}
