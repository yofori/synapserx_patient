// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insurancepolicy.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_InsurancePolicy _$$_InsurancePolicyFromJson(Map<String, dynamic> json) =>
    _$_InsurancePolicy(
      id: json['_id'] as String,
      code: json['code'] as String?,
      insuranceCompanyName: json['insuranceCompanyName'] as String?,
      policyNo: json['policyNo'] as String?,
      benefitPackageCode: json['benefitPackageCode'] as String?,
      benefitPackageName: json['benefitPackageName'] as String?,
      startDate: json['startDate'] as String?,
      expiryDate: json['expiryDate'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      iV: json['iV'] as int?,
    );

Map<String, dynamic> _$$_InsurancePolicyToJson(_$_InsurancePolicy instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'code': instance.code,
      'insuranceCompanyName': instance.insuranceCompanyName,
      'policyNo': instance.policyNo,
      'benefitPackageCode': instance.benefitPackageCode,
      'benefitPackageName': instance.benefitPackageName,
      'startDate': instance.startDate,
      'expiryDate': instance.expiryDate,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'iV': instance.iV,
    };
