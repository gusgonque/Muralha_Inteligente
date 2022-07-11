import 'dart:isolate';
import 'dart:ui';

import 'package:background_locator/background_locator.dart';
import 'package:background_locator/settings/android_settings.dart';
import 'package:background_locator/settings/ios_settings.dart';
import 'package:background_locator/settings/locator_settings.dart';
import 'package:flutter/material.dart';

const String _isolateName = "LocatorIsolate";
ReceivePort port = ReceivePort();

//TODO: usar o background_locator?

@override
void initState() {
  super.initState();

  IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  port.listen((dynamic data) {
    // do something with data
  });
  initPlatformState();
}

Future<void> initPlatformState() async {
  await BackgroundLocator.initialize();
}

static void callback(LocationDto locationDto) async {
final SendPort? send = IsolateNameServer.lookupPortByName(_isolateName);
send?.send(locationDto);
}

//Optional
static void notificationCallback() {
  print('User clicked on the notification');
}

void startLocationService(){
  BackgroundLocator.registerLocationUpdate(LocationCallbackHandler.callback,
      initCallback: LocationCallbackHandler.initCallback,
      initDataCallback: data,
      disposeCallback: LocationCallbackHandler.disposeCallback,
      autoStop: false,
      iosSettings: IOSSettings(
          accuracy: LocationAccuracy.NAVIGATION, distanceFilter: 0),
      androidSettings: AndroidSettings(
          accuracy: LocationAccuracy.NAVIGATION,
          interval: 5,
          distanceFilter: 0,
          androidNotificationSettings: AndroidNotificationSettings(
              notificationChannelName: 'Location tracking',
              notificationTitle: 'Start Location Tracking',
              notificationMsg: 'Track location in background',
              notificationBigMsg:
              'Background location is on to keep the app up-tp-date with your location. This is required for main features to work properly when the app is not running.',
              notificationIcon: '',
              notificationIconColor: Colors.grey,
              notificationTapCallback:
              LocationCallbackHandler.notificationCallback)));
}