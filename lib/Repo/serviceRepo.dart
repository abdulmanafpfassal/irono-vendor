import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:irono/Network/webService.dart';
import 'package:irono/Utils/network_urls.dart';

class ServiceRepo {
  ApiService _apiService = ApiService();

  Future<Map<String, dynamic>> fetchServiceCategories() async {
    Map<String, dynamic> responseData = {};
    try {
      Map<String, String> headers = {"Content-Type": "application/json"};

      final response = await _apiService.postResponse(
          NetworkUrls.service_categories, jsonEncode({}), headers);
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

  Future<Map<String, dynamic>> saveServiceDetails(var body) async {
    Map<String, dynamic> responseData = {};
    try {
      Map<String, String> headers = {"Content-Type": "application/json"};

      final response = await _apiService.postResponse(
          NetworkUrls.submit_service_details, jsonEncode(body), headers);
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

  Future<Map<String, dynamic>> fetchPendingServices(var body) async {
    Map<String, dynamic> responseData = {};
    try {
      Map<String, String> headers = {"Content-Type": "application/json"};

      final response = await _apiService.postResponse(
          NetworkUrls.pending_service, jsonEncode(body), headers);
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


  Future<Map<String, dynamic>> fetchAcceptedOrders(var body) async {
    Map<String, dynamic> responseData = {};
    try {
      Map<String, String> headers = {"Content-Type": "application/json"};

      final response = await _apiService.postResponse(
          NetworkUrls.acceptedOrders, jsonEncode(body), headers);
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


  Future<Map<String, dynamic>> fetchCompletedOrders(var body) async {
    Map<String, dynamic> responseData = {};
    try {
      Map<String, String> headers = {"Content-Type": "application/json"};

      final response = await _apiService.postResponse(
          NetworkUrls.completed_service, jsonEncode(body), headers);
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

  Future<Map<String, dynamic>> fetchHomepageData(var body) async {
    Map<String, dynamic> responseData = {};
    try {
      Map<String, String> headers = {"Content-Type": "application/json"};

      final response = await _apiService.postResponse(
          NetworkUrls.homePageData, jsonEncode(body), headers);
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


   Future<Map<String, dynamic>> fetchNotifications(var body) async {
    Map<String, dynamic> responseData = {};
    try {
      Map<String, String> headers = {"Content-Type": "application/json"};

      final response = await _apiService.postResponse(
          NetworkUrls.getNotifications, jsonEncode(body), headers);
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

  Future<Map<String, dynamic>> fetchServiceDetails(var body) async {
    Map<String, dynamic> responseData = {};
    try {
      Map<String, String> headers = {"Content-Type": "application/json"};

      final response = await _apiService.postResponse(
          NetworkUrls.singleServiceDetails, jsonEncode(body), headers);
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

  Future<Map<String, dynamic>> updateServiceDetails(var body) async {
    Map<String, dynamic> responseData = {};
    try {
      Map<String, String> headers = {"Content-Type": "application/json"};

      final response = await _apiService.postResponse(
          NetworkUrls.updateServiceDetails, jsonEncode(body), headers);
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

  Future<Map<String, dynamic>> acceptOrder(var body) async {
    Map<String, dynamic> responseData = {};
    try {
      Map<String, String> headers = {"Content-Type": "application/json"};

      final response = await _apiService.postResponse(
          NetworkUrls.acceptOrder, jsonEncode(body), headers);
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

  Future<Map<String, dynamic>> completeOrder(var body) async {
    Map<String, dynamic> responseData = {};
    try {
      Map<String, String> headers = {"Content-Type": "application/json"};

      final response = await _apiService.postResponse(
          NetworkUrls.completeOrder, jsonEncode(body), headers);
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



  Future<Map<String, dynamic>> submitContactUs(var body) async {
    Map<String, dynamic> responseData = {};
    try {
      Map<String, String> headers = {"Content-Type": "application/json"};

      final response = await _apiService.postResponse(
          NetworkUrls.submitContactUs, jsonEncode(body), headers);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);

        responseData = responseBody;
        log("response data is" + responseBody.toString());
      }
    } catch (e) {
      log("the exception is " + e.toString());
    }
    return responseData;
  }



    Future<Map<String, dynamic>> fetchContactUs(var body) async {
    Map<String, dynamic> responseData = {};
    try {
      Map<String, String> headers = {"Content-Type": "application/json"};

      final response = await _apiService.postResponse(
          NetworkUrls.contactUs, jsonEncode(body), headers);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);

        responseData = responseBody;
        log("response data is" + responseBody.toString());
      }
    } catch (e) {
      log("the exception is " + e.toString());
    }
    return responseData;
  }

  Future<Map<String, dynamic>> termsAndConditions(var body) async {
    Map<String, dynamic> responseData = {};
    try {
      Map<String, String> headers = {"Content-Type": "application/json"};

      final response = await _apiService.postResponse(
          NetworkUrls.terms, jsonEncode(body), headers);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);

        responseData = responseBody;
        log("response data is" + responseBody.toString());
      }
    } catch (e) {
      log("the exception is " + e.toString());
    }
    return responseData;
  }

  Future<Map<String, dynamic>> saveFeedback(var body) async {
    Map<String, dynamic> responseData = {};
    try {
      Map<String, String> headers = {"Content-Type": "application/json"};

      final response = await _apiService.postResponse(
          NetworkUrls.saveFeedBack, jsonEncode(body), headers);
      log("status is ${response.body}");
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);

        responseData = responseBody;
        log("response data is" + responseBody.toString());
      }
    } catch (e) {
      log("the exception is " + e.toString());
    }
    return responseData;
  }

  Future<Map<String, dynamic>> privacyPolicy(var body) async {
    Map<String, dynamic> responseData = {};
    try {
      Map<String, String> headers = {"Content-Type": "application/json"};

      final response = await _apiService.postResponse(
          NetworkUrls.privacyPolicy, jsonEncode(body), headers);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);

        responseData = responseBody;
        log("response data is" + responseBody.toString());
      }
    } catch (e) {
      log("the exception is " + e.toString());
    }
    return responseData;
  }

}
