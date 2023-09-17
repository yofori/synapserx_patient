import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synapserx_patient/services/dio_client.dart';

import '../models/labrequest.dart';

part 'labrequests_provider.g.dart';

@riverpod
class LabRequests extends _$LabRequests {
  Future<List<LabRequest>> _getLabinvestigations() async {
    final prescriptions = await DioClient().getLabinvestigations();
    return prescriptions;
  }

  @override
  FutureOr<List<LabRequest>> build() async {
    return _getLabinvestigations();
  }

  Future<void> refreshLabinvestigations() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_getLabinvestigations);
  }
}
