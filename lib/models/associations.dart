import 'package:freezed_annotation/freezed_annotation.dart';
part 'associations.freezed.dart';
part 'associations.g.dart';

@freezed
class Associations with _$Associations {
  const factory Associations(
      {@JsonKey(name: '_id') required String id,
      required String prescriberuid,
      required String patientuid,
      String? status,
      required String patientFullname,
      required String prescriberFullname,
      String? createdAt,
      String? updatedAt,
      int? iV}) = _Associations;

  factory Associations.fromJson(Map<String, dynamic> json) =>
      _$AssociationsFromJson(json);
}
