import 'package:freezed_annotation/freezed_annotation.dart';
part 'insurancepolicy.freezed.dart';
part 'insurancepolicy.g.dart';

@freezed
class InsurancePolicy with _$InsurancePolicy {
  const factory InsurancePolicy(
      {@JsonKey(name: '_id') required String id,
      String? code,
      String? insuranceCompanyName,
      String? policyNo,
      String? benefitPackageCode,
      String? benefitPackageName,
      String? startDate,
      String? expiryDate,
      String? createdAt,
      String? updatedAt,
      int? iV}) = _InsurancePolicy;

  factory InsurancePolicy.fromJson(Map<String, dynamic> json) =>
      _$InsurancePolicyFromJson(json);
}
