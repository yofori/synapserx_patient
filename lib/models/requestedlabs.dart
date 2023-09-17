import 'package:json_annotation/json_annotation.dart';
part 'requestedlabs.g.dart';

@JsonSerializable()
class RequestedLabs {
  String orderedTestCode;
  String orderedTestDescription;
  String diagnosticService;

  RequestedLabs(
      {required this.orderedTestCode,
      required this.orderedTestDescription,
      required this.diagnosticService});

  factory RequestedLabs.fromJson(Map<String, dynamic> json) =>
      _$RequestedLabsFromJson(json);

  Map<String, dynamic> toJson() => _$RequestedLabsToJson(this);
}
