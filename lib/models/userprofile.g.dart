// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userprofile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserProfile _$$_UserProfileFromJson(Map<String, dynamic> json) =>
    _$_UserProfile(
      fullname: json['fullname'] as String?,
      firebaseUID: json['firebaseUID'] as String?,
      surname: json['surname'] as String?,
      firstname: json['firstname'] as String?,
      title: json['title'] as String?,
      dateOfBirth: json['dateOfBirth'] as String?,
      ageAtRegistration: json['ageAtRegistration'] as int?,
      isAgeEstimated: json['isAgeEstimated'] as bool? ?? true,
      gender: json['gender'] as String?,
      telephone: json['telephone'] as String?,
      countryCode: json['countryCode'] as String?,
      email: json['email'] as String?,
      nationalIdNo: json['nationalIdNo'] as String?,
      nationalHealthInsurancedNo: json['nationalHealthInsurancedNo'] as String?,
      patientuid: json['patientuid'] as String?,
      active: json['active'] as bool? ?? false,
    );

Map<String, dynamic> _$$_UserProfileToJson(_$_UserProfile instance) =>
    <String, dynamic>{
      'fullname': instance.fullname,
      'firebaseUID': instance.firebaseUID,
      'surname': instance.surname,
      'firstname': instance.firstname,
      'title': instance.title,
      'dateOfBirth': instance.dateOfBirth,
      'ageAtRegistration': instance.ageAtRegistration,
      'isAgeEstimated': instance.isAgeEstimated,
      'gender': instance.gender,
      'telephone': instance.telephone,
      'countryCode': instance.countryCode,
      'email': instance.email,
      'nationalIdNo': instance.nationalIdNo,
      'nationalHealthInsurancedNo': instance.nationalHealthInsurancedNo,
      'patientuid': instance.patientuid,
      'active': instance.active,
    };
