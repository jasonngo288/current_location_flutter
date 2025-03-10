import Flutter
import UIKit
import CoreLocation

public class NativeLocationPlugin: NSObject, FlutterPlugin, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    private var result: FlutterResult?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "native_location_plugin", binaryMessenger: registrar.messenger())
        let instance = NativeLocationPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "getCurrentLocation" {
            self.result = result
            requestLocation()
        } else {
            result(FlutterMethodNotImplemented)
        }
    }

    private func requestLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            result?(["latitude": location.coordinate.latitude, "longitude": location.coordinate.longitude])
            result = nil
        }
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        result?(FlutterError(code: "LOCATION_ERROR", message: error.localizedDescription, details: nil))
    }
}
