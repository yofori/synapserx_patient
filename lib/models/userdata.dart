import 'package:json_annotation/json_annotation.dart';

part 'userdata.g.dart';

@JsonSerializable()
class UserData {
  String fullname;

  UserData({required this.fullname});

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
