import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'native_location_plugin_method_channel.dart';

abstract class MyLocationPluginPlatform extends PlatformInterface {
  /// Constructs a MyLocationPluginPlatform.
  MyLocationPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static MyLocationPluginPlatform _instance = MethodChannelMyLocationPlugin();

  /// The default instance of [MyLocationPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelMyLocationPlugin].
  static MyLocationPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MyLocationPluginPlatform] when
  /// they register themselves.
  static set instance(MyLocationPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
