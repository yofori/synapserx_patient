import 'package:json_annotation/json_annotation.dart';
import 'requestedlabs.dart';

part 'labrequest.g.dart';

@JsonSerializable(explicitToJson: true)
class LabRequest {
  @JsonKey(name: '_id')
  String? sId;
  String pxId;
  String pxSurname;
  String pxFirstname;
  String pxgender;
  int? pxAge;
  String? pxDOB;
  String? prescriberID;
  String? prescriberMDCRegNo;
  String? prescriberName;
  String? prescriberSignature;
  String? prescriberInstitution;
  String? prescriberInstitutionName;
  String? prescriberInstitutionAddress;
  String? prescriberInstitutionTelephone;
  String? prescriberInstitutionEmail;
  String? status;
  List<String>? diagnoses;
  List<RequestedLabs>? requests;
  String? createdAt;
  String? updatedAt;

  LabRequest({
    this.sId,
    required this.pxId,
    required this.pxSurname,
    required this.pxFirstname,
    required this.pxgender,
    this.pxAge,
    this.pxDOB,
    this.prescriberID,
    this.prescriberMDCRegNo,
    this.prescriberName,
    this.prescriberSignature,
    this.prescriberInstitution,
    this.prescriberInstitutionName,
    this.prescriberInstitutionAddress,
    this.prescriberInstitutionTelephone,
    this.prescriberInstitutionEmail,
    this.status,
    this.diagnoses,
    this.requests,
    this.createdAt,
    this.updatedAt,
  });

  factory LabRequest.fromJson(Map<String, dynamic> json) =>
      _$LabRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LabRequestToJson(this);
}
