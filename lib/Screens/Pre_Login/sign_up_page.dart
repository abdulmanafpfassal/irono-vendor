import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../Utils/colors.dart';
import 'otp_page.dart';

class SignUpFormWidget extends StatefulWidget {
  @override
  _SignUpFormWidgetState createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  final _formKey = GlobalKey<FormState>();

  String _businessName = '';
  String _businessPhone = '';
  String _businessEmail = '';
  String _serviceCategory = 'Select a category';
  String _serviceName = '';
  String _serviceCost = '';
  String _location = '';

  final picker = ImagePicker();
  File? _shopImage;

  getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);


    if (pickedFile != null) {
      _shopImage = File(pickedFile.path);
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
              TextFormField(
                decoration: InputDecoration(labelText: 'Business Phone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your business phone';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _businessPhone = value;
                  });
                },
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
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Service Category'),
                value: _serviceCategory,
                items: ['Select a category','Ironing', 'Laundry'].map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category, style: GoogleFonts.inter(fontSize: 12.sp),),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _serviceCategory = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select service category';
                  }
                  return null;
                },
              ),
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
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your location';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _location = value;
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) => OtpPage()));
                    }
                  },
                  child: Text(
                    "Sign In",
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
