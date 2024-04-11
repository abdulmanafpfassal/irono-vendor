import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:irono/Provider/AuthProvider.dart';
import 'package:irono/Repo/serviceRepo.dart';
import 'package:irono/Utils/custom.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceProvider with ChangeNotifier {
  ServiceRepo serviceRepo = ServiceRepo();
  Map<String, dynamic> categories = {};
  List<String> categoryList = [];
  Map<String, dynamic> pendingServices = {};
  Map<String, dynamic> acceptedOrders = {};
  Map<String, dynamic> completedOrders = {};
  Map<String, dynamic> notifications = {};
  Map<String, dynamic> terms = {};
  Map<String, dynamic> privacyPolicy = {};
  Map<String, dynamic> contactUs = {};

  dynamic selectedServiceId;
  Map<String, dynamic> serviceDetail = {};
  fetchCategories() async {
    categoryList.clear();
    categoryList.add("Select a Category");
    categories = await serviceRepo.fetchServiceCategories();
    for (int i = 0; i < categories['result']['data']['result'].length; i++) {
      var category = categories['result']['data']['result'][i];
      categoryList.add(category["name"]);
    }
    notifyListeners();
  }

  fetchHomePageDatas(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var phoneNumber = await sharedPreferences.getString("phone_number");
    var body = {"phone": phoneNumber};
    final response = await serviceRepo.fetchHomepageData(body);
    context.read<AuthProvider>().setLoginResponse(response);
  }

  fetchPendingServices(BuildContext context) async {
    var userId = context.read<AuthProvider>().vendorId;
    var body = {"user": userId};
    pendingServices = await serviceRepo.fetchPendingServices(body);
    notifyListeners();
  }

  submitFeedback(feedBack, BuildContext context) async {
    LoadingOverlay.show(context);
    var userId = context.read<AuthProvider>().vendorId;
    var body = {"user": userId, "message": feedBack};
    await serviceRepo.saveFeedback(body);
    LoadingOverlay.hide();
    showToast("Feedback submitted successfully");
  }

  fetchContactUs(BuildContext context) async {
    var userId = context.read<AuthProvider>().vendorId;
    var body = {"user": userId};
    log("clicked here $body");
    contactUs = await serviceRepo.fetchContactUs(body);
    notifyListeners();
  }

  saveContactUs(BuildContext context, subject, description, priority) async {
    LoadingOverlay.show(context);
    var userId = context.read<AuthProvider>().vendorId;
    var body = {
      "user": userId,
      "subject": subject,
      "description": description,
      "priority": priority
    };
    await serviceRepo.submitContactUs(body);
    LoadingOverlay.hide();
    showToast("Submitted your data successfully");
  }

  fetchTermsAndConditions(BuildContext context) async {
    var userId = context.read<AuthProvider>().vendorId;
    var body = {"user": userId};
    terms = await serviceRepo.termsAndConditions(body);
    notifyListeners();
  }

  fetchPrivacyPolicy(BuildContext context) async {
    var userId = context.read<AuthProvider>().vendorId;
    var body = {"user": userId};
    privacyPolicy = await serviceRepo.privacyPolicy(body);
    notifyListeners();
  }

  fetchNotifications(BuildContext context) async {
    var userId = context.read<AuthProvider>().vendorId;
    var body = {"user": userId};
    notifications = await serviceRepo.fetchNotifications(body);
    notifyListeners();
  }

  setSelectedServiceId(id) {
    this.selectedServiceId = id;
  }

  fetchSingleServiceDetails(BuildContext context) async {
    var userId = context.read<AuthProvider>().vendorId;
    var body = {"user": userId, "product_id": selectedServiceId};
    serviceDetail = await serviceRepo.fetchServiceDetails(body);
    notifyListeners();
  }

  editServices(name, cost, categoryId, reference_no, BuildContext context,
      description) async {
    var userId = context.read<AuthProvider>().vendorId;
    var body = {
      "user": userId,
      "product_id": selectedServiceId,
      "name": name,
      "standard_price": cost,
      "lst_price": cost,
      "categ_id": int.parse(categoryId),
      "reference_no": reference_no,
      "description": description
    };
    log('request body is $body');
    final response = await serviceRepo.updateServiceDetails(body);
    showToast("Service updated Successfully");
    Navigator.pop(context);
  }

  addNewService(name, cost, categoryId, reference_no, BuildContext context,
      var description) async {
    var userId = context.read<AuthProvider>().vendorId;
    var body = {
      "user": userId,
      "description": description,
      "name": name,
      "sales_price": cost,
      "cost": cost,
      "category": int.parse(categoryId),
      "reference": reference_no
    };
    log('request body is $body');
    final response = await serviceRepo.saveServiceDetails(body);
    showToast("Service added Successfully");
    Navigator.pop(context);
    fetchHomePageDatas(context);
  }

  acceptOrder(BuildContext context, orderId) async {
    var userId = context.read<AuthProvider>().vendorId;
    var body = {"user": userId, "order_id": orderId};
    await serviceRepo.acceptOrder(body);
    showToast("Order accepted successfully");
    await fetchPendingServices(context);
    await fetchAcceptedorders(context);
  }

  fetchAcceptedorders(BuildContext context) async {
    var userId = context.read<AuthProvider>().vendorId;
    var body = {"user": userId};
    acceptedOrders = await serviceRepo.fetchAcceptedOrders(body);
    notifyListeners();
  }

  fetchCompletedorders(BuildContext context) async {
    var userId = context.read<AuthProvider>().vendorId;
    var body = {"user": userId};
    completedOrders = await serviceRepo.fetchCompletedOrders(body);
    notifyListeners();
  }

  completeOrder(BuildContext context, otp, orderId) async {
    var userId = context.read<AuthProvider>().vendorId;
    var body = {"user": userId, "otp": int.parse(otp), "order_id": orderId};
    final response = await serviceRepo.completeOrder(body);
    if (response['result']['message'] ==
        "Incorrect OTP. Order Not Completed !") {
      showToast("Incorrect OTP. Order Not Completed !");
    } else {
      showToast("Order marked as completed successfully");
      await fetchCompletedorders(context);
    }
  }
}
