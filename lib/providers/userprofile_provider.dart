import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synapserx_patient/models/userprofile.dart';
import 'package:synapserx_patient/services/dio_client.dart';

part 'userprofile_provider.g.dart';

@riverpod
class AsyncUserProfile extends _$AsyncUserProfile {
  Future<UserProfile> _fetchUserProfile() async {
    state = const AsyncLoading();
    final profile = await DioClient().getProfile();
    return profile;
  }

  @override
  FutureOr<UserProfile> build() async {
    return _fetchUserProfile();
  }

  void setIsAgeEastimated(bool checked) {
    if (!state.hasValue) return;
    final value = state.value;
    state = AsyncData(value!.copyWith(isAgeEstimated: !checked));
  }
}
