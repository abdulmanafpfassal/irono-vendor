import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:irono/Provider/AuthProvider.dart';
import 'package:irono/Utils/colors.dart';
import 'package:irono/Utils/custom.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController businessName = TextEditingController();
  TextEditingController businessEmail = TextEditingController();
  TextEditingController businessPhone = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0), () async {
       await context.read<AuthProvider>().fetchProfileDetails();
      var profileDetails = context.read<AuthProvider>().profileDetails;
      nameController.text = profileDetails['result']['data']['name'];
      emailController.text = profileDetails['result']['data']['email'];
      phoneController.text = profileDetails['result']['data']['phone'];
      businessName.text = profileDetails['result']['data']['bussiness_name'];
      businessPhone.text = profileDetails['result']['data']['bussiness_phone'];
      businessEmail.text = profileDetails['result']['data']['bussiness_email'];
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Enter your Name",
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Enter your Email",
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  hintText: "Enter your Phone Number",
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              TextField(
                controller: businessName,
                decoration: InputDecoration(
                  hintText: "Enter your Business Name",
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              TextField(
                controller: businessEmail,
                decoration: InputDecoration(
                  hintText: "Enter your Business Email",
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              TextField(
                controller: businessPhone,
                decoration: InputDecoration(
                  hintText: "Enter your Business Phone Number",
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(ColorUtils().primary)),
                  onPressed: () async {
                    LoadingOverlay.show(context);
                    await context.read<AuthProvider>().updateProfile(
                        context,
                        nameController.text,
                        emailController.text,
                        phoneController.text,
                        businessName.text,
                        businessEmail.text,
                        businessPhone.text);
                    LoadingOverlay.hide();
                  },
                  child: Text(
                    "Update Profile",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
