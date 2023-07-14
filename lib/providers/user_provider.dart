import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synapserx_patient/models/userdata.dart';

class UserDataNotifier extends StateNotifier<UserData> {
  UserDataNotifier(UserData state) : super(state);

  void setFullname(String fullname) {
    state = state..fullname = fullname;
  }
}

final userDataProvider = StateNotifierProvider<UserDataNotifier, UserData>((_) {
  return UserDataNotifier(UserData(fullname: ''));
});
