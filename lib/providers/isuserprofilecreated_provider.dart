import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfileCreated extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void setValue(bool value) {
    state = value;
  }
}

final userProfileCreatedProvider = NotifierProvider<UserProfileCreated, bool>(
  () {
    return UserProfileCreated();
  },
);
