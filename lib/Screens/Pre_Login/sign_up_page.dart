import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:irono/Provider/AuthProvider.dart';
import 'package:irono/Provider/serviceProvider.dart';
import 'package:irono/Utils/custom.dart';
import 'package:provider/provider.dart';

import '../../Utils/colors.dart';
import 'otp_page.dart';

class SignUpFormWidget extends StatefulWidget {
  @override
  _SignUpFormWidgetState createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  final _formKey = GlobalKey<FormState>();

  String _businessName = '';
  String _firstName = "";
  String _businessPhone = '';
  String _businessEmail = '';
  String _serviceCategory = 'Select a Category';
  String _serviceName = '';
  String _serviceCost = '';
  String _location = '';
  String description = '';
  String selectedCategoryId = '';
  String? base64Image;
  final picker = ImagePicker();
  File? _shopImage;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0), () async {
      await context.read<ServiceProvider>().fetchCategories();
    });
  }

  getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _shopImage = File(pickedFile.path);
      List<int> imageBytes = await _shopImage!.readAsBytes();
      base64Image = base64Encode(imageBytes);

      // Now you have the base64 encoded string representation of the image
      print(base64Image);
      setState(() {});
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                child: Stack(
                  children: [
                    if (_shopImage != null)
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            _shopImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: getImage,
                      ),
                    ),
                  ],
                ),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Your Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _firstName = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Business Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your business name';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _businessName = value;
                  });
                },
              ),
              // TextFormField(
              //   decoration: InputDecoration(labelText: 'Business Phone'),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter your business phone';
              //     }
              //     return null;
              //   },
              //   onChanged: (value) {
              //     setState(() {
              //       _businessPhone = value;
              //     });
              //   },
              // ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    // border: Border.all(
                    //     color: ColorUtils().primary.withOpacity(0.4)),
                    // borderRadius: BorderRadius.circular(10.r)
                    ),
                width: MediaQuery.sizeOf(context).width,
                child: IntlPhoneField(
                  // controller: _controller,

                  initialCountryCode: 'IN',
                  disableLengthCheck: true,

                  decoration: InputDecoration(
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 11.sp, color: Colors.grey),
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                        // borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10.r)),
                  ),
                  languageCode: "en",
                  onChanged: (phone) {
                    _businessPhone = phone.completeNumber;
                    // state.setPhoneNumber(phone.completeNumber.toString());
                  },
                  onCountryChanged: (country) {},
                ),
              ),

              TextFormField(
                decoration: InputDecoration(labelText: 'Business Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your business email';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _businessEmail = value;
                  });
                },
              ),
              // Add fields for shop image, government ID, service name, service category, service cost, and location here
              // For simplicity, I'm adding just the basic text form fields for now
              TextFormField(
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
                      } else if (base64Image == null) {
                        showToast("Choose an image to continue");
                      } else {
                        LoadingOverlay.show(context);
                        await context.read<AuthProvider>().saveBusinessDetails(
                            _businessName,
                            _businessPhone.toString().split("+")[1],
                            _businessEmail,
                            selectedCategoryId,
                            _location,
                            _serviceCost,
                            description,
                            base64Image);
                        await context.read<AuthProvider>().signUp(
                            _firstName,
                            "",
                            _businessEmail,
                            _businessPhone.toString().split("+")[1],
                            context);
                        LoadingOverlay.hide();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OtpPage(
                                  phoneNumber:
                                      _businessPhone.toString().split("+")[1],
                                  from: FROM.SignUp,
                                )));
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
