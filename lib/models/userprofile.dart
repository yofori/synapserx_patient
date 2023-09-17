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
      String? countryCode,
      String? email,
      String? nationalIdNo,
      String? nationalHealthInsurancedNo,
      String? patientuid,
      @Default(false) bool? active}) = _UserProfile;

  static Future<UserProfile> get initialState async => const UserProfile();

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
