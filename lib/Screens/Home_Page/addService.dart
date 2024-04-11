import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:irono/Provider/serviceProvider.dart';
import 'package:irono/Utils/colors.dart';
import 'package:irono/Utils/custom.dart';
import 'package:provider/provider.dart';

class AddService extends StatefulWidget {
  const AddService({super.key});

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0), () async {
      await context.read<ServiceProvider>().fetchCategories();
    });
  }

  String _serviceCategory = 'Select a Category';
  String _serviceName = '';
  String _serviceCost = '';
  String _location = '';
  String description = '';
  String selectedCategoryId = '';
  TextEditingController serviceNameController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController referenceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Service'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: serviceNameController,
                decoration: InputDecoration(labelText: 'Service Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter service name';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _serviceName = value;
                  });
                },
              ),
              Consumer<ServiceProvider>(builder: (context, state, _) {
                return state.categoryList.isNotEmpty
                    ? DropdownButtonFormField<String>(
                        decoration:
                            InputDecoration(labelText: 'Service Category'),
                        value: _serviceCategory,
                        // items:
                        //     ['Select a category', 'Ironing', 'Laundry'].map((category) {
                        items:
                            state.categoryList.toSet().toList().map((category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(
                              category,
                              style: GoogleFonts.inter(fontSize: 12.sp),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _serviceCategory = value!;
                            if (_serviceCategory != 'Select a Category') {
                              int index = state.categories['result']['data']
                                      ['result']
                                  .indexWhere(
                                      (e) => e["name"] == _serviceCategory);
                              log("index is $index");
                              selectedCategoryId = state.categories['result']
                                      ['data']['result'][index]['id']
                                  .toString();
                            }
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select service category';
                          }
                          return null;
                        },
                      )
                    : SizedBox();
              }),
              TextFormField(
                controller: costController,
                decoration: InputDecoration(labelText: 'Service Cost'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter service cost';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _serviceCost = value;
                  });
                },
              ),
              TextFormField(
                controller: referenceController,
                decoration: InputDecoration(labelText: 'Reference'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your reference';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _location = value;
                  });
                },
              ),
              TextFormField(
                maxLines: 3,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your description';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    description = value;
                  });
                },
              ),
              SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 40.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: ColorUtils().primary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r), // <-- Radius
                      )),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (_serviceCategory == "Select a Category") {
                        showToast("Please select a category to continue");
                      } else {
                        LoadingOverlay.show(context);
                        await context.read<ServiceProvider>().addNewService(
                            serviceNameController.text,
                            costController.text,
                            selectedCategoryId,
                            referenceController.text,
                            context,
                            description);
                        LoadingOverlay.hide();
                      }
                    }
                  },
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
