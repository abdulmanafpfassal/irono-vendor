import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:irono/Network/webService.dart';
import 'package:irono/Utils/network_urls.dart';

class AuthRepo {
  ApiService _service = ApiService();

  Future<Map<String, dynamic>> signUp(BuildContext context, var body) async {
    Map<String, dynamic> responseData = {};
    try {
      Map<String, String> headers = {"Content-Type": "application/json"};

      final response = await _service.postResponse(
          NetworkUrls.sign_up, jsonEncode(body), headers);
      log("message" + response.body.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        responseData = responseBody;
      }
    } catch (e) {
      log("the exception is " + e.toString());
    }
    return responseData;
  }

  Future<Map<String, dynamic>> login(BuildContext context, var body) async {
    Map<String, dynamic> responseData = {};
    try {
      Map<String, String> headers = {"Content-Type": "application/json"};

      final response = await _service.postResponse(
          NetworkUrls.login_url, jsonEncode(body), headers);
      log("message" + response.body.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        responseData = responseBody;
      }
    } catch (e) {
      log("the exception is " + e.toString());
    }
    return responseData;
  }


Future<Map<String, dynamic>> profileDetails( var body) async {
    Map<String, dynamic> responseData = {};
    try {
      Map<String, String> headers = {"Content-Type": "application/json"};

      final response = await _service.postResponse(
          NetworkUrls.profileDetails, jsonEncode(body), headers);
      log("message" + response.body.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        responseData = responseBody;
      }
    } catch (e) {
      log("the exception is " + e.toString());
    }
    return responseData;
  }


  Future<Map<String, dynamic>> updateProfile( var body) async {
    Map<String, dynamic> responseData = {};
    try {
      Map<String, String> headers = {"Content-Type": "application/json"};

      final response = await _service.postResponse(
          NetworkUrls.updateProfile, jsonEncode(body), headers);
      log("message" + response.body.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        responseData = responseBody;
      }
    } catch (e) {
      log("the exception is " + e.toString());
    }
    return responseData;
  }

  Future<Map<String, dynamic>> verify(var body) async {
    Map<String, dynamic> responseData = {};
    try {
      Map<String, String> headers = {"Content-Type": "application/json"};

      final response = await _service.postResponse(
          NetworkUrls.otp_verification, jsonEncode(body), headers);
      log("message" + response.body.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        responseData = responseBody;
      }
    } catch (e) {
      log("the exception is " + e.toString());
    }
    return responseData;
  }

  Future<Map<String, dynamic>> saveBusinessDetails(var body) async {
    Map<String, dynamic> responseData = {};
    try {
      Map<String, String> headers = {"Content-Type": "application/json"};

      final response = await _service.postResponse(
          NetworkUrls.submit_business_details, jsonEncode(body), headers);
      log("message" + response.body.toString());
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        responseData = responseBody;
      }
    } catch (e) {
      log("the exception is " + e.toString());
    }
    return responseData;
  }
}
