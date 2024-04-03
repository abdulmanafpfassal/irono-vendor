import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NavigationProvider with ChangeNotifier {

  MENU initialPage = MENU.HOME;
  BOOKING initialBooking = BOOKING.PENDING;

  setInitialPage(MENU page){
    initialPage = page;
    notifyListeners();
  }

  setInitialBooking(BOOKING page){
    initialBooking = page;
    notifyListeners();
  }



}

enum MENU { HOME, BOOKMARK, NOTIFICATION, MESSAGE }
enum BOOKING {PENDING, ACCEPTED, COMPLETED}