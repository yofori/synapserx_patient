// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'labrequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LabRequest _$LabRequestFromJson(Map<String, dynamic> json) => LabRequest(
      sId: json['_id'] as String?,
      pxId: json['pxId'] as String,
      pxSurname: json['pxSurname'] as String,
      pxFirstname: json['pxFirstname'] as String,
      pxgender: json['pxgender'] as String,
      pxAge: json['pxAge'] as int?,
      pxDOB: json['pxDOB'] as String?,
      prescriberID: json['prescriberID'] as String?,
      prescriberMDCRegNo: json['prescriberMDCRegNo'] as String?,
      prescriberName: json['prescriberName'] as String?,
      prescriberSignature: json['prescriberSignature'] as String?,
      prescriberInstitution: json['prescriberInstitution'] as String?,
      prescriberInstitutionName: json['prescriberInstitutionName'] as String?,
      prescriberInstitutionAddress:
          json['prescriberInstitutionAddress'] as String?,
      prescriberInstitutionTelephone:
          json['prescriberInstitutionTelephone'] as String?,
      prescriberInstitutionEmail: json['prescriberInstitutionEmail'] as String?,
      status: json['status'] as String?,
      diagnoses: (json['diagnoses'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      requests: (json['requests'] as List<dynamic>?)
          ?.map((e) => RequestedLabs.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$LabRequestToJson(LabRequest instance) =>
    <String, dynamic>{
      '_id': instance.sId,
      'pxId': instance.pxId,
      'pxSurname': instance.pxSurname,
      'pxFirstname': instance.pxFirstname,
      'pxgender': instance.pxgender,
      'pxAge': instance.pxAge,
      'pxDOB': instance.pxDOB,
      'prescriberID': instance.prescriberID,
      'prescriberMDCRegNo': instance.prescriberMDCRegNo,
      'prescriberName': instance.prescriberName,
      'prescriberSignature': instance.prescriberSignature,
      'prescriberInstitution': instance.prescriberInstitution,
      'prescriberInstitutionName': instance.prescriberInstitutionName,
      'prescriberInstitutionAddress': instance.prescriberInstitutionAddress,
      'prescriberInstitutionTelephone': instance.prescriberInstitutionTelephone,
      'prescriberInstitutionEmail': instance.prescriberInstitutionEmail,
      'status': instance.status,
      'diagnoses': instance.diagnoses,
      'requests': instance.requests?.map((e) => e.toJson()).toList(),
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
