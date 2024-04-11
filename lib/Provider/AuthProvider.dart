import 'package:flutter/material.dart';
import 'package:irono/Repo/AuthRepo.dart';
import 'package:irono/Repo/serviceRepo.dart';
import 'package:irono/Utils/custom.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  AuthRepo _loginRepo = AuthRepo();
  String? _businessName;
  String? _businessPhone;
  String? _businessEmail;
  String? selectedCategory;
  String? reference;
  String? cost;
  String? description;
  var vendorId;
  Map<String, dynamic> loginResponse = {};
  String? image;
  Map profileDetails = {};

  signUp(fname, lname, email, phoneNumber, BuildContext context) async {
    var body = {
      "first_name": fname,
      "last_name": lname,
      "email": email,
      "phone": phoneNumber
    };
    var reponse = await _loginRepo.signUp(context, body);
  }

  verifyOtp(phoneNumber, otp) async {
    var body = {"phone": phoneNumber, "otp": otp};
    var response = await _loginRepo.verify(body);
    this.vendorId = response['result']['data']['user_id'];
    this.loginResponse = response;

    return response;
  }

  saveBusinessDetails(
      name, phone, email, category, reference, cost, description, image) {
    this._businessName = name;
    this._businessEmail = email;
    this._businessPhone = phone;
    this.selectedCategory = category;
    this.reference = reference;
    this.cost = cost;
    this.description = description;
    this.image = image;
  }

  login(phoneNumber, BuildContext context) async {
    var body = {"phone": phoneNumber};
    var response = await _loginRepo.login(context, body);

    return response;
  }

  submitBusinessDetails(userId) async {
    this.vendorId = userId;
    var body = {
      "name": _businessName,
      "phone": _businessPhone,
      "email": _businessEmail,
      "user": userId,
      "image": image
    };
    var response = await _loginRepo.saveBusinessDetails(body);
    ServiceRepo serviceRepo = ServiceRepo();
    var serviceBody = {
      "name": _businessName,
      "reference": reference,
      "cost": cost,
      "sales_price": cost,
      "category": int.parse(selectedCategory.toString()),
      "description": description,
      "user": userId
    };
    await serviceRepo.saveServiceDetails(serviceBody);
  }

  setLoginResponse(var data) {
    this.loginResponse = data;
    this.vendorId = data['result']['data']['user_id'];
    notifyListeners();
  }

  fetchProfileDetails() async {
    var body = {"user": vendorId};
    profileDetails = await _loginRepo.profileDetails(body);
    notifyListeners();
  }

  updateProfile(BuildContext context, name, email, phone, b_name, b_email,
      b_phone) async {
    var body = {
      "user": vendorId,
      "name": name,
      "email": email,
      "phone": phone,
      "bussiness_name": b_name,
      "bussiness_phone": b_phone,
      "bussiness_email": b_email
    };
    await _loginRepo.updateProfile(body);

    await fetchProfileDetails();
    Navigator.pop(context);
    showToast("Profile updated successfully");
  }
}
