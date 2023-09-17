import 'dart:developer';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:synapserx_patient/models/associations.dart';
import 'package:synapserx_patient/models/insurancepolicy.dart';
import 'package:synapserx_patient/models/labrequest.dart';
import 'package:synapserx_patient/widgets/synapsepx_snackbar.dart';
import '../models/prescription.dart';
import '../models/userprofile.dart';
import '../widgets/custom_exception.dart';
import 'dio_tokens.dart';
import 'settings.dart';

class DioClient {
  DioClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: "${GlobalData.baseUrl}/api",
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        )..interceptors.addAll([
            Tokens(),
          ]);

  final Dio _dio;

  Future<dynamic> test() async {
    log('testing endpoint');
    try {
      Response response = await _dio.get(
        '/user/test',
      );
      return response.data;
    } on DioException catch (err) {
      final errorMessage = err.message.toString();
      log(errorMessage);
      var data = {'Message': errorMessage};
      return data;
    }
  }

  Future<UserProfile> getProfile() async {
    try {
      Response response = await _dio.get('/user/getprofile');
      return UserProfile.fromJson(response.data);
    } on DioException catch (err) {
      if (err.response?.data['message'] == 'no-profile-exists') {
        throw CustomException('no-profile-exists');
      } else if (err.type == DioExceptionType.connectionError) {
        throw CustomException(
            'A network error (such as timeout, interrupted connection or unreachable host) has occurred.');
      } else {
        throw CustomException(err.error.toString());
      }
    }
  }

  Future<bool> updateProfileInfo({required data}) async {
    try {
      Response response = await _dio.put('/user/updateprofile', data: data);
      if (response.statusCode == 200) {
        // print('Successfully updated patient profile');
        return true;
      }
    } on DioException catch (err) {
      throw CustomException(err.message.toString());
    }
    return false;
  }

  Future<bool> createProfileInfo({required data}) async {
    try {
      Response response = await _dio.post('/user/createprofile', data: data);
      if (response.statusCode == 201) {
        // print('Successfully created patient profile');
        return true;
      }
    } on DioException catch (err) {
      throw CustomException(err.message.toString());
    }
    return false;
  }

  Future<List<Associations>> getPrescribers() async {
    try {
      Response response = await _dio.get('/user/listprescribers');
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((x) => Associations.fromJson(x))
            .toList();
      }
    } on DioException catch (err) {
      final errorMessage = (err).toString();
      throw errorMessage;
    }
    return [];
  }

  Future<List<InsurancePolicy>> getPxInsurancePolicies() async {
    try {
      Response response = await _dio.get('/user/getpxinsurancepolicies');
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((x) => InsurancePolicy.fromJson(x))
            .toList();
      }
    } on DioException catch (err) {
      final errorMessage = (err).toString();
      log(errorMessage);
      throw errorMessage;
    }
    return [];
  }

  Future<void> addInsurancePolicy({required data}) async {
    try {
      Response response =
          await _dio.post('/user/createinsurancepolicy', data: data);
      if (response.statusCode == 201) {
        // print('Successfully created patient profile');
      }
    } on DioException catch (err) {
      debugPrint(err.message);
    }
  }

  Future<void> updateInsurancePolicy({required data}) async {
    try {
      Response response =
          await _dio.put('/user/updateinsurancepolicy', data: data);
      if (response.statusCode == 200) {
        // print('Successfully update patient profile');
      }
    } on DioException catch (err) {
      debugPrint(err.message);
    }
  }

  Future<void> deleteInsurancePolicy({required policyId}) async {
    try {
      Response response =
          await _dio.put('/user/deleteinsurancepolicy/$policyId');
      if (response.statusCode == 200) {
        // print('Successfully update patient profile');
      }
    } on DioException catch (err) {
      debugPrint(err.message);
    }
  }

  Future<List<Prescription>> getPrescriptions() async {
    try {
      Response response = await _dio.get('/user/getprescriptions');
      return (response.data as List)
          .map((x) => Prescription.fromJson(x))
          .toList();
    } on DioException catch (err) {
      final errorMessage = (err).toString();
      throw errorMessage;
    }
  }

  Future<List<LabRequest>> getLabinvestigations() async {
    try {
      Response response = await _dio.get('/user/getlabinvestigations');
      return (response.data as List)
          .map((x) => LabRequest.fromJson(x))
          .toList();
    } on DioException catch (err) {
      final errorMessage = (err).toString();
      throw errorMessage;
    }
  }

  Future<dynamic> addAssociation({required String prescriberid}) async {
    try {
      Response response = await _dio.post(
        '/user/addprescriber',
        data: {
          'prescriberuid': prescriberid,
          'patientFullname': GlobalData.fullname
        },
      );
      if (response.statusCode == 201) {
        GlobalSnackBar.show(
            'The prescriber has been successfully added', Colors.green, false);
        return response.data;
      }
    } on DioException catch (err) {
      log(err.response.toString());
      GlobalSnackBar.show(err.response?.data['error'], Colors.red, false);
      return null;
    }
  }
}
