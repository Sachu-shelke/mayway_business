// ignore_for_file: use_build_context_synchronously
import 'package:flutter_contacts/flutter_contacts.dart';
// import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mayway_business/config/manager/global_singleton.dart';
import 'package:mayway_business/utils/progress_indicator.dart';
import 'package:location/location.dart' as loc;


class UserLocation {
  Circle circle = Circle();
  Future<String> getCurrentPosition(
      Function()? afterSuccess, BuildContext? context, int index,
      {bool? dontDo}) async {
    if (context != null) circle.show(context);
    loc.Location location = loc.Location();
    bool ison = await location.serviceEnabled();
    if (!ison) {
      bool isturnedon = await location.requestService();
      if (!isturnedon) {
        if (context != null) circle.hide(context);
        return "PERMISSION";
      }
    }

    if (GlobalSingleton.currentPosition != null) {
      if (context != null) circle.hide(context);
      return "SUCCESS";
    }
    final bool hasPermission =
        await handleLocationPermission(afterSuccess, dontDo: dontDo);

    if (!hasPermission) {
      if (context != null) circle.hide(context);
      return "FAILED";
    }

    try {
      final LocationPermission hasPermission =
          await Geolocator.checkPermission();
      if (hasPermission.name != "denied") {
        final Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
        );
        GlobalSingleton.currentPosition = position;
        if (context != null) circle.hide(context);
        return "SUCCESS";
      } else {
        return "FAILED";
      }

      // return _getAddressFromLatLng(position);
    } on Position catch (_) {
      if (context != null) circle.hide(context);
      return "FAILED";
    }
  }

  Future<bool> handleLocationPermission(Function()? afterSuccess,
      {bool? dontDo}) async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied && dontDo != true) {
        // appRouter
        //     .push(LocationPermissionScreenRoute(afterSuccess: afterSuccess));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever && dontDo != true) {
      // appRouter.push(LocationPermissionScreenRoute(afterSuccess: afterSuccess));
      return false;
    }

    return true;
  }
}

class UserContact {
  Circle circle = Circle();

  Future<String> getLatestContact(Function()? afterSuccess, BuildContext? context, int index,
      {bool? dontDo}) async {
    if (context != null) circle.show(context);

    // Request permission using flutter_contacts instead of permission_handler
    bool hasPermission = await FlutterContacts.requestPermission();

    if (!hasPermission) {
      if (context != null) circle.hide(context);
      return "FAILED";
    }

    // If contacts are already fetched, return success
    if (GlobalSingleton.contact.isNotEmpty) {
      if (context != null) circle.hide(context);
      return "SUCCESS";
    }

    try {
      // Fetch contacts
      List<Contact> getContact = await FlutterContacts.getContacts();
      GlobalSingleton.contact = getContact;

      if (context != null) circle.hide(context);
      return "SUCCESS";
    } catch (e) {
      if (context != null) circle.hide(context);
      return "FAILED";
    }
  }
}

