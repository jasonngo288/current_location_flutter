import 'package:flutter/material.dart';
import 'package:my_location_plugin/my_location_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _location = "Unknown";

  Future<void> _getLocation() async {
    try {
      final location = await MyLocationPlugin.getCurrentLocation();
      setState(() {
        _location = "Latitude: ${location['latitude']}, Longitude: ${location['longitude']}";
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
            Text(_location),
            ElevatedButton(onPressed: _getLocation, child: Text("Get Location")),
          ],
        )),
      ),
    );
  }
}
