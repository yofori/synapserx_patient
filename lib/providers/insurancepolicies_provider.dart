import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:synapserx_patient/services/dio_client.dart';

import '../models/insurancepolicy.dart';

part 'insurancepolicies_provider.g.dart';

@riverpod
class InsurancePolicies extends _$InsurancePolicies {
  Future<List<InsurancePolicy>> _getInsurancePolicies() async {
    final insurancePolicies = await DioClient().getPxInsurancePolicies();
    return insurancePolicies;
  }

  @override
  FutureOr<List<InsurancePolicy>> build() async {
    return _getInsurancePolicies();
  }

  Future<void> addInsurancePolicy(insurancePolicy) async {
    // Set the state to loading
    state = const AsyncValue.loading();
    // Add the new todo and reload the todo list from the remote repository
    state = await AsyncValue.guard(() async {
      await DioClient().addInsurancePolicy(data: insurancePolicy);
      return _getInsurancePolicies();
    });
  }

  Future<void> updateInsurancePolicy(insurancePolicy) async {
    // Set the state to loading
    state = const AsyncValue.loading();
    // Add the new todo and reload the todo list from the remote repository
    state = await AsyncValue.guard(() async {
      await DioClient().updateInsurancePolicy(data: insurancePolicy);
      return _getInsurancePolicies();
    });
  }

  Future<void> deleteInsurancePolicy(insurancePolicyNo) async {
    // Set the state to loading
    state = const AsyncValue.loading();
    // Add the new todo and reload the todo list from the remote repository
    state = await AsyncValue.guard(() async {
      await DioClient().deleteInsurancePolicy(policyId: insurancePolicyNo);
      return _getInsurancePolicies();
    });
  }
}
