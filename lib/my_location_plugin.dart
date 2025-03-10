import 'dart:async';
import 'package:flutter/services.dart';

class MyLocationPlugin {
  static const MethodChannel _channel = MethodChannel('my_location_plugin');

  static Future<Map<String, double>> getCurrentLocation() async {
    final Map<String, double> location = Map<String, double>.from(await _channel.invokeMethod('getCurrentLocation'));
    return location;
  }
}
