import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synapserx_patient/services/dio_client.dart';

import '../models/prescription.dart';

part 'prescriptions_provider.g.dart';

@riverpod
class Prescriptions extends _$Prescriptions {
  Future<List<Prescription>> _getPrescriptions() async {
    final prescriptions = await DioClient().getPrescriptions();
    return prescriptions;
  }

  @override
  FutureOr<List<Prescription>> build() async {
    return _getPrescriptions();
  }

  Future<void> refreshPrescription() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_getPrescriptions);
  }
}
