import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'native_location_plugin_platform_interface.dart';

/// An implementation of [MyLocationPluginPlatform] that uses method channels.
class MethodChannelMyLocationPlugin extends MyLocationPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('native_location_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
