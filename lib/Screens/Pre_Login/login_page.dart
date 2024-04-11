import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:irono/Provider/AuthProvider.dart';
import 'package:irono/Screens/Pre_Login/otp_page.dart';
import 'package:irono/Screens/Pre_Login/sign_up_page.dart';
import 'package:irono/Utils/colors.dart';
import 'package:irono/Utils/custom.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FocusNode focusNode = FocusNode();
  TextEditingController phoneController = TextEditingController();
  String? phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 100.h,
              width: 100.w,
              child: Image.asset(
                "assets/images/logo_irono.png",
                fit: BoxFit.contain,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Login ",
                      style: GoogleFonts.poppins(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    Text(
                      "with your ",
                      style: GoogleFonts.poppins(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                Text(
                  "phone number ",
                  style: GoogleFonts.poppins(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Container(
                  // decoration: BoxDecoration(
                  //     color: ColorUtils().offWhite,
                  //     borderRadius: BorderRadius.circular(10.r)),
                  width: MediaQuery.sizeOf(context).width,
                  child: IntlPhoneField(
                    initialCountryCode: 'IN',
                    disableLengthCheck: true,
                    focusNode: focusNode,
                    controller: phoneController,
                    decoration: InputDecoration(
                      hintStyle: GoogleFonts.poppins(fontSize: 11.sp),
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                          // borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.r)),
                    ),
                    languageCode: "en",
                    onChanged: (phone) {
                      phoneNumber = phone.completeNumber;
                    },
                    onCountryChanged: (country) {},
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 40.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorUtils().primary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10.r), // <-- Radius
                        )),
                    onPressed: () async {
                      if (phoneController.text.isEmpty) {
                        showToast("Number cannot be empty");
                      } else {
                        LoadingOverlay.show(context);
                        final response = await context
                            .read<AuthProvider>()
                            .login(
                                phoneNumber.toString().split("+")[1], context);
                        LoadingOverlay.hide();
                        if (response["result"]["message"] ==
                            "User does not exists. Sign Up !") {
                          showToast("User does not exists. Please sign up");
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => OtpPage(
                                    phoneNumber:
                                        phoneNumber.toString().split("+")[1],
                                    from: FROM.Login,
                                  )));
                        }
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
            Container()
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Create a New Account",
              style: GoogleFonts.inter(
                  fontSize: 11.sp, color: Colors.grey.withOpacity(0.9)),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SignUpFormWidget()));
              },
              child: Text(
                " Sign Up",
                style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    color: ColorUtils().primary,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
