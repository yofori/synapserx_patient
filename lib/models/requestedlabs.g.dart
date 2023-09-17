// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'requestedlabs.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestedLabs _$RequestedLabsFromJson(Map<String, dynamic> json) =>
    RequestedLabs(
      orderedTestCode: json['orderedTestCode'] as String,
      orderedTestDescription: json['orderedTestDescription'] as String,
      diagnosticService: json['diagnosticService'] as String,
    );

Map<String, dynamic> _$RequestedLabsToJson(RequestedLabs instance) =>
    <String, dynamic>{
      'orderedTestCode': instance.orderedTestCode,
      'orderedTestDescription': instance.orderedTestDescription,
      'diagnosticService': instance.diagnosticService,
    };
