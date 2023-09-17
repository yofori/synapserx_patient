import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synapserx_patient/services/dio_client.dart';

import '../models/associations.dart';

part 'prescribers_provider.g.dart';

@riverpod
class Prescribers extends _$Prescribers {
  Future<List<Associations>> _getPrescribers() async {
    final prescribers = await DioClient().getPrescribers();
    return prescribers;
  }

  @override
  FutureOr<List<Associations>> build() async {
    return _getPrescribers();
  }

  Future<void> addPrescriber(prescriberuid) async {
    // Set the state to loading
    state = const AsyncValue.loading();
    // Add the new todo and reload the todo list from the remote repository
    state = await AsyncValue.guard(() async {
      await DioClient().addAssociation(prescriberid: prescriberuid);
      return _getPrescribers();
    });
  }

  Future<void> refreshPrescriber() async {
    // Set the state to loading
    state = const AsyncValue.loading();
    // Add the new todo and reload the todo list from the remote repository
    state = await AsyncValue.guard(() async {
      return _getPrescribers();
    });
  }
}
