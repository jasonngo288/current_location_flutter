package com.example.mylocationplugin

import android.app.Activity
import android.content.pm.PackageManager
import android.location.Location
import android.os.Looper
import androidx.core.app.ActivityCompat
import com.google.android.gms.location.*
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MyLocationPlugin : FlutterPlugin, MethodChannel.MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel
    private lateinit var fusedLocationClient: FusedLocationProviderClient
    private var activity: Activity? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(binding.binaryMessenger, "my_location_plugin")
        channel.setMethodCallHandler(this)
        fusedLocationClient = LocationServices.getFusedLocationProviderClient(binding.applicationContext)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (call.method == "getCurrentLocation") {
            getCurrentLocation(result)
        } else {
            result.notImplemented()
        }
    }

    private fun getCurrentLocation(result: MethodChannel.Result) {
        activity?.let {
            if (ActivityCompat.checkSelfPermission(it, android.Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
                ActivityCompat.requestPermissions(it, arrayOf(android.Manifest.permission.ACCESS_FINE_LOCATION), 100)
                result.error("PERMISSION_DENIED", "Permission not granted", null)
                return
            }

            fusedLocationClient.lastLocation.addOnSuccessListener { location: Location? ->
                location?.let {
                    result.success(mapOf("latitude" to it.latitude, "longitude" to it.longitude))
                } ?: result.error("LOCATION_ERROR", "Location not found", null)
            }
        }
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() { activity = null }
    override fun onDetachedFromActivityForConfigChanges() {}
    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}
    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
