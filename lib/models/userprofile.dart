import 'package:freezed_annotation/freezed_annotation.dart';
part 'userprofile.freezed.dart';
part 'userprofile.g.dart';

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile(
      {String? fullname,
      String? firebaseUID,
      String? surname,
      String? firstname,
      String? title,
      String? dateOfBirth,
      int? ageAtRegistration,
      @Default(true) bool isAgeEstimated,
      String? gender,
      String? telephone,
      String? email,
      String? nationalIdNo,
      String? nationalHealthInsurancedNo,
      @Default(false) bool? active}) = _UserProfile;

  static UserProfile get initialState => const UserProfile();

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
