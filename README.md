# 📍 Native Location Plugin  

[![Pub Version](https://img.shields.io/pub/v/native_location_plugin.svg)](https://pub.dev/packages/native_location_plugin)  
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)  

A Flutter plugin to get the current location using **native APIs** (Swift for iOS, Kotlin for Android).  
Supports **high-accuracy location retrieval** with a simple and lightweight implementation.  

---

## 🚀 Features  
✅ Get current latitude & longitude using native location services  
✅ Supports both **Android** & **iOS**  
✅ Lightweight & easy to integrate  
✅ Uses **Google Fused Location Provider** for Android  
✅ Uses **CoreLocation** for iOS  

---

## 📦 Installation  
Add this to your `pubspec.yaml`:  

```yaml
dependencies:
  native_location_plugin: latest_version
```

---

## 📲 Permissions
# Android
Add these permissions to your `AndroidManifest.xml`:
```
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>

```
Also, update `android/app/build.gradle` with:
```
minSdkVersion 21
```
# iOS
Open `ios/Runner/Info.plist` and add:

```
<key>NSLocationWhenInUseUsageDescription</key>
<string>App needs access to your location</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>App requires location access even in the background</string>

```
## 📌 Usage

Import the package:
```
import 'package:native_location_plugin/native_location_plugin.dart';
```

Get Current Location
```
void getLocation() async {
  try {
    final location = await NativeLocationPlugin.getCurrentLocation();
    print("Latitude: ${location['latitude']}, Longitude: ${location['longitude']}");
  } catch (e) {
    print("Error: $e");
  }
}
```

## 🛠️ Example
Here's a simple Flutter app using this plugin:
```
import 'package:flutter/material.dart';
import 'package:native_location_plugin/native_location_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _location = "Unknown";

  Future<void> _fetchLocation() async {
    try {
      final loc = await NativeLocationPlugin.getCurrentLocation();
      setState(() {
        _location = "Lat: ${loc['latitude']}, Lng: ${loc['longitude']}";
      });
    } catch (e) {
      setState(() { _location = "Error: $e"; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Location Plugin Example")),
        body: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_location, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _fetchLocation, child: Text("Get Location")),
          ],
        )),
      ),
    );
  }
}
```
## 📜 License
MIT

## 🏷️ Tags
Flutter, Location, GPS, Geolocation, Native Plugin, Android, iOS
