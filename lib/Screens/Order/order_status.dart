import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:irono/Provider/navigation_provider.dart';
import 'package:irono/Provider/serviceProvider.dart';
import 'package:irono/Utils/colors.dart';
import 'package:irono/Utils/custom.dart';
import 'package:provider/provider.dart';

class BookingHistory extends StatefulWidget {
  const BookingHistory({super.key});

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 0), () async {
      await context.read<ServiceProvider>().fetchPendingServices(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 75.h),
        child: Consumer<NavigationProvider>(builder: (context, state, _) {
          return Column(
            children: [
              AppBar(
                title: Text(
                  "Booking History",
                  style: GoogleFonts.inter(
                      fontSize: 13.sp, fontWeight: FontWeight.w600),
                ),
                backgroundColor: Colors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                      onTap: () {
                        state.setInitialBooking(BOOKING.PENDING);
                      },
                      child: Column(
                        children: [
                          Text(
                            "Received",
                            style: GoogleFonts.inter(
                                color: state.initialBooking == BOOKING.PENDING
                                    ? ColorUtils().primary
                                    : Colors.black),
                          ),
                        ],
                      )),
                  InkWell(
                      onTap: () async {
                        state.setInitialBooking(BOOKING.ACCEPTED);
                        await context
                            .read<ServiceProvider>()
                            .fetchAcceptedorders(context);
                      },
                      child: Column(
                        children: [
                          Text(
                            "Accepted",
                            style: GoogleFonts.inter(
                                color: state.initialBooking == BOOKING.ACCEPTED
                                    ? ColorUtils().primary
                                    : Colors.black),
                          ),
                        ],
                      )),
                  InkWell(
                      onTap: () async {
                        state.setInitialBooking(BOOKING.COMPLETED);
                        await context
                            .read<ServiceProvider>()
                            .fetchCompletedorders(context);
                      },
                      child: Column(
                        children: [
                          Text(
                            "Completed",
                            style: GoogleFonts.inter(
                                color: state.initialBooking == BOOKING.COMPLETED
                                    ? ColorUtils().primary
                                    : Colors.black),
                          ),
                        ],
                      )),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          state.setInitialBooking(BOOKING.PENDING);
                        },
                        child: Container(
                          height: 2.h,
                          decoration: BoxDecoration(
                              color: state.initialBooking == BOOKING.PENDING
                                  ? ColorUtils().primary
                                  : Colors.white),
                        )),
                  ),
                  Expanded(
                    child: InkWell(
                        onTap: () async {
                          state.setInitialBooking(BOOKING.ACCEPTED);
                          await context
                              .read<ServiceProvider>()
                              .fetchAcceptedorders(context);
                        },
                        child: Container(
                          height: 2.h,
                          decoration: BoxDecoration(
                              color: state.initialBooking == BOOKING.ACCEPTED
                                  ? ColorUtils().primary
                                  : Colors.white),
                        )),
                  ),
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          state.setInitialBooking(BOOKING.COMPLETED);
                        },
                        child: Container(
                          height: 2.h,
                          decoration: BoxDecoration(
                              color: state.initialBooking == BOOKING.COMPLETED
                                  ? ColorUtils().primary
                                  : Colors.white),
                        )),
                  ),
                ],
              )
            ],
          );
        }),
      ),
      body: Consumer<NavigationProvider>(builder: (context, state, _) {
        return Container(
          margin: EdgeInsets.all(10.0),
          child: state.initialBooking == BOOKING.PENDING
              ? Consumer<ServiceProvider>(builder: (context, state, _) {
                  return state.pendingServices.isNotEmpty
                      ? Column(
                          children: [
                            // serviceCard(
                            //     image: "assets/images/ironing_service.jpg",
                            //     service: "Ironing Service",
                            //     price: "120"),
                            ListView.builder(
                              itemCount: state
                                  .pendingServices['result']['data']['result']
                                  .length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var service = state.pendingServices['result']
                                    ['data']['result'][index];
                                log("service is $service");
                                return serviceCard(
                                    image: "assets/images/ironing_service.jpg",
                                    service: service['name'].toString(),
                                    type: "received",
                                    orderedServices: service['order_line'],
                                    id: service['id'],
                                    price: service['amount_total'].toString());
                              },
                            )
                          ],
                        )
                      : SizedBox();
                })
              : state.initialBooking == BOOKING.ACCEPTED
                  ? Consumer<ServiceProvider>(builder: (context, state, _) {
                      return state.acceptedOrders.isNotEmpty
                          ? Column(
                              children: [
                                // serviceCard(
                                //     image: "assets/images/ironing_service.jpg",
                                //     service: "Ironing Service",
                                //     price: "120"),
                                ListView.builder(
                                  itemCount: state
                                      .acceptedOrders['result']['data']
                                          ['result']
                                      .length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    var service = state.acceptedOrders['result']
                                        ['data']['result'][index];
                                    log("service is $service");
                                    return serviceCard(
                                        image:
                                            "assets/images/ironing_service.jpg",
                                        service: service['name'].toString(),
                                        type: "received",
                                        orderedServices: service['order_line'],
                                        id: service['id'],
                                        price:
                                            service['amount_total'].toString());
                                  },
                                )
                              ],
                            )
                          : SizedBox();
                    })
                  : state.initialBooking == BOOKING.COMPLETED
                      ? Consumer<ServiceProvider>(builder: (context, state, _) {
                          return state.completedOrders.isNotEmpty
                              ? Column(
                                  children: [
                                    // serviceCard(
                                    //     image: "assets/images/ironing_service.jpg",
                                    //     service: "Ironing Service",
                                    //     price: "120"),
                                    ListView.builder(
                                      itemCount: state
                                          .completedOrders['result']['data']
                                              ['result']
                                          .length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        var service =
                                            state.completedOrders['result']
                                                ['data']['result'][index];
                                        log("service is $service");
                                        return serviceCard(
                                            image:
                                                "assets/images/ironing_service.jpg",
                                            service: service['name'].toString(),
                                            type: "completed",
                                            orderedServices:
                                                service['order_line'],
                                            id: service['id'],
                                            price: service['amount_total']
                                                .toString());
                                      },
                                    )
                                  ],
                                )
                              : SizedBox();
                        })
                      : Container(),
        );
      }),
    );
  }

  Widget serviceCard(
      {required String image,
      required String service,
      required String price,
      required orderedServices,
      required type,
      required id}) {
    return InkWell(
      onTap: () {},
      child: Container(
        // margin: EdgeInsets.symmetric(horizontal: 10.w
        // ),
        padding: EdgeInsets.all(10),
        // height: 120.h,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(10.r)),
        child: Row(
          children: [
            Container(
                width: 130.w,
                height: 130.h,
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                )),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
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
                  SizedBox(
                    height: 7.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ordered Services",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            fontSize: 11.sp,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: orderedServices.length,
                        itemBuilder: (context, index) {
                          log('ordered services ${orderedServices[index]}');
                          var service = orderedServices[index];
                          return Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Product : ${service['product']}'),
                                Text('Quantity : ${service['qty'].toString()}'),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 5,
                      ),
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
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 3.h),
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
                          ),
                          Spacer(),
                          Consumer<NavigationProvider>(
                              builder: (context, state, _) {
                            return state.initialBooking == BOOKING.ACCEPTED
                                ? TextButton(
                                    style: ButtonStyle(
                                        padding: MaterialStateProperty.all(
                                            EdgeInsets.zero),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                ColorUtils().primary)),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text("Confirmation"),
                                            content: Text(
                                              "Are you sure you want to mark this order as complete ? Note that you have to enter an OTP from customer's end to complete this order.",
                                              style: GoogleFonts.inter(),
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () async {
                                                    String? otp;
                                                    Navigator.pop(context);
                                                    showDialog(
                                                      context: context,
                                                      barrierDismissible: true,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              "Confirmation"),
                                                          actions: [
                                                            TextButton(
                                                                onPressed:
                                                                    () async {
                                                                  log("here");
                                                                  LoadingOverlay
                                                                      .show(
                                                                          context);
                                                                  await context
                                                                      .read<
                                                                          ServiceProvider>()
                                                                      .completeOrder(
                                                                          context,
                                                                          otp,
                                                                          id);
                                                                  LoadingOverlay
                                                                      .hide();
                                                                  Navigator.pop(
                                                                      context);
                                                                  context
                                                                      .read<
                                                                          NavigationProvider>()
                                                                      .setInitialBooking(
                                                                          BOOKING
                                                                              .ACCEPTED);
                                                                },
                                                                child: Text(
                                                                    "Submit"))
                                                          ],
                                                          content: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Text(
                                                                "Enter the OTP from customer's end to complete the order.",
                                                                style:
                                                                    GoogleFonts
                                                                        .inter(),
                                                              ),
                                                              TextField(
                                                                decoration:
                                                                    InputDecoration(
                                                                        hintText:
                                                                            "Enter the OTP"),
                                                                onChanged:
                                                                    (value) {
                                                                  log("otp is $value");
                                                                  otp = value;
                                                                },
                                                              )
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Text("Yes")),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("No"))
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Text(
                                      "Complete",
                                      style: GoogleFonts.inter(
                                          color: Colors.white),
                                    ))
                                : type == 'received'
                                    ? TextButton(
                                        style: ButtonStyle(
                                            padding: MaterialStateProperty.all(
                                                EdgeInsets.zero),
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    ColorUtils().primary)),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text("Confirmation"),
                                                content: Text(
                                                  "Are you sure you want to accept this order and move it to accepted orders ?",
                                                  style: GoogleFonts.inter(),
                                                ),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () async {
                                                        LoadingOverlay.show(
                                                            context);
                                                        await context
                                                            .read<
                                                                ServiceProvider>()
                                                            .acceptOrder(
                                                                context, id);
                                                        LoadingOverlay.hide();
                                                        Navigator.pop(context);
                                                        context
                                                            .read<
                                                                NavigationProvider>()
                                                            .setInitialBooking(
                                                                BOOKING
                                                                    .ACCEPTED);
                                                      },
                                                      child: Text("Yes")),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text("No"))
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: Text(
                                          "Accept",
                                          style: GoogleFonts.inter(
                                              color: Colors.white),
                                        ))
                                    : SizedBox();
                          })
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                  Consumer<NavigationProvider>(builder: (context, state, _) {
                    return state.initialBooking == BOOKING.ACCEPTED
                        ? Text(
                            "For completing the order you should enter the OTP from customer",
                            style: GoogleFonts.inter(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey),
                          )
                        : SizedBox();
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
