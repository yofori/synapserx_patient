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
}
