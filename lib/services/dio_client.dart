import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:synapserx_patient/models/associations.dart';
import 'package:synapserx_patient/models/insurancepolicy.dart';
import '../models/userprofile.dart';
import 'dio_tokens.dart';
import 'settings.dart';

class DioClient {
  DioClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: "${GlobalData.baseUrl}/api",
            connectTimeout: const Duration(seconds: 50),
            receiveTimeout: const Duration(seconds: 30),
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
      print(response.data);
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
      print(response.data);
      return UserProfile.fromJson(response.data);
    } on DioException catch (err) {
      if (err.response?.data['message'] == 'no-profile-exists') {
        // do something if the profile is empty here
      }
    }
    return UserProfile.initialState;
  }

  Future<bool> updateProfileInfo({required data}) async {
    try {
      Response response = await _dio.put('/user/updateprofile', data: data);
      if (response.statusCode == 200) {
        print('Successfully updated patient profile');
        return true;
      }
    } on DioException catch (err) {
      debugPrint(err.message);
    }
    return false;
  }

  Future<bool> createProfileInfo({required data}) async {
    try {
      Response response = await _dio.post('/user/createprofile', data: data);
      if (response.statusCode == 201) {
        print('Successfully created patient profile');
        return true;
      }
    } on DioException catch (err) {
      debugPrint(err.message);
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
      debugPrint(err.message);
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
      debugPrint(err.message);
    }
    return [];
  }

  Future<void> addInsurancePolicy({required data}) async {
    try {
      Response response =
          await _dio.post('/user/createinsurancepolicy', data: data);
      if (response.statusCode == 201) {
        print('Successfully created patient profile');
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
        print('Successfully update patient profile');
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
        print('Successfully update patient profile');
      }
    } on DioException catch (err) {
      debugPrint(err.message);
    }
  }
}
