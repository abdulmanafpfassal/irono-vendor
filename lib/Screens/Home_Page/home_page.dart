import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:irono/Provider/AuthProvider.dart';
import 'package:irono/Provider/serviceProvider.dart';
import 'package:irono/Screens/Home_Page/addService.dart';
import 'package:irono/Screens/Home_Page/edit_services.dart';
import 'package:irono/Screens/service/service_details.dart';
import 'package:irono/Utils/colors.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0), () async {
      await context.read<ServiceProvider>().fetchHomePageDatas(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        // leading: const Icon(Icons.menu),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Current Location",
              style: GoogleFonts.inter(fontSize: 11.sp),
            ),
            Row(
              children: [
                Text(
                  "Abu Dhabi",
                  style: GoogleFonts.inter(
                      fontSize: 12.sp, fontWeight: FontWeight.w600),
                ),
                Icon(Icons.arrow_drop_down_outlined)
              ],
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<AuthProvider>(builder: (context, state, _) {
                return state.loginResponse.isNotEmpty
                    ? state.loginResponse['result']!=null? CarouselSlider(
                        // items: [
                        //   Image.asset("assets/images/banner1.png"),
                        //   Image.asset("assets/images/banner1.png")
                        // ],
                        items: List.generate(
                            state.loginResponse['result']['data']['banners']
                                .length,
                            (index) => Image.network(
                                state.loginResponse['result']['data']['banners']
                                    [index]['image'])).toList(),
                        options: CarouselOptions(
                            // height: 152,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            aspectRatio: 16 / 9,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enableInfiniteScroll: true,
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            viewportFraction: 0.8,
                            scrollDirection: Axis.horizontal,
                            padEnds: false),
                      )
                    : SizedBox():SizedBox();
              }),

              SizedBox(
                height: 11.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Our Services",
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddService()));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          border:
                              Border.all(color: Colors.black.withOpacity(0.5))),
                      child: Row(
                        children: [
                          Text(
                            "Add New",
                            style: GoogleFonts.inter(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            Icons.add,
                            size: 11.sp,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 11.h,
              ),
              Consumer<AuthProvider>(builder: (context, state, _) {
                return state.loginResponse.isNotEmpty
                    ? SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: List.generate(
                            state
                                .loginResponse['result']['data']
                                    ['services_providered']
                                .length,
                            (index) => serviceCard(
                                image: state.loginResponse['result']['data']
                                    ['services_providered'][index]['image'],
                                service: state.loginResponse['result']['data']
                                    ['services_providered'][index]['name'],
                                id: state.loginResponse['result']['data']
                                    ['services_providered'][index]['id'],
                                price: state.loginResponse['result']['data']
                                        ['services_providered'][index]
                                        ['lst_price']
                                    .toString()),
                          ).toList(),
                        ),
                      )
                    : SizedBox();
              }),
              // Consumer<AuthProvider>(builder: (context, state, _) {
              //   return state.loginResponse.isNotEmpty
              //       ? ListView.builder(
              //         itemCount: state.loginResponse['result']['data']['services_providered'].length,
              //           itemBuilder: (context, index) {
              //             var service = state.loginResponse['result']['data']['services_providered'][index];
              //             return serviceCard(
              //                 image: "assets/images/laundry_service.jpg",
              //                 service: service['name'],
              //                 price: "200");
              //           },
              //         )
              //       : SizedBox();
              // })
            ],
          ),
        ),
      ),
    );
  }

  Widget serviceCard(
      {required String image,
      required String service,
      required String price,
      required id}) {
    return InkWell(
      onTap: () {
        context.read<ServiceProvider>().setSelectedServiceId(id);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => EditServices()));
      },
      child: Container(
        // margin: EdgeInsets.symmetric(horizontal: 10.w
        // ),
        padding: EdgeInsets.all(10),
        height: 110.h,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(10.r)),
        child: Row(
          children: [
            Container(
                width: 130.w,
                height: 130.h,
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                )),
            SizedBox(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Row(
                //   children: [
                //     Icon(
                //       Icons.star,
                //       color: Colors.yellow,
                //     ),
                //     SizedBox(
                //       width: 5.w,
                //     ),
                //     Text(
                //       "4.8",
                //       style: GoogleFonts.inter(
                //         fontSize: 11.sp,
                //         fontWeight: FontWeight.w600,
                //       ),
                //     ),
                //     SizedBox(
                //       width: 5.w,
                //     ),
                //     Text(
                //       "(48)",
                //       style: GoogleFonts.inter(
                //           fontSize: 11.sp,
                //           fontWeight: FontWeight.w600,
                //           color: Colors.black.withOpacity(0.7)),
                //     ),
                //   ],
                // ),

                Text(
                  service,
                  style: GoogleFonts.inter(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Price Starts From",
                      style: GoogleFonts.inter(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withOpacity(0.7)),
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Colors.green),
                      child: Text(
                        "AED ${price}",
                        style: GoogleFonts.inter(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
