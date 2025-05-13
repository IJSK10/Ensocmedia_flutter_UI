import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:project/src/states/sharedpreferences.dart";

final loginProvider =
    StateNotifierProvider.autoDispose<LoginNotifier, bool>((ref) {
  ref.keepAlive();
  return LoginNotifier(ref: ref);
});

class LoginNotifier extends StateNotifier<bool> {
  LoginNotifier({required this.ref}) : super(false) {
    state = ref.watch(sharedUtilityProvider).isLoggedin();
  }
  Ref ref;
  void turnlogin() {
    ref.watch(sharedUtilityProvider).setLoggin(isLogin: true);
    state = true;
  }

  void turnlogoff() {
    ref.watch(sharedUtilityProvider).setLoggin(isLogin: false);
    state = false;
  }
}

final loginprovider = StateProvider<bool>((ref) {
  return false;
});
