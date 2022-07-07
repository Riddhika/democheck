import 'dart:async';
import 'dart:math';
import 'package:sensors/sensors.dart';
import 'package:flutter/services.dart';

/// Callback for phone shakes
typedef PhoneShakeCallback = void Function();

class FlutterShakePlugin {
  /// callback for phone shake
  final PhoneShakeCallback? onPhoneShaken;

  /// Minimum time between shake
  final int shakeTimeMS;

  /// Last shake time
  var _lastTime = 0;

  /// Shake detection threshold
  final double shakeThresholdGravity;

  /// if do vibration when phone shakes
  final bool shouldVibrate;

  /// vibration duration
  final int vibrateDuration;

  /// StreamSubscription for Accelerometer events
  StreamSubscription? streamSubscription;

  /// This constructor waits until [startListening] is called
  FlutterShakePlugin({
    this.onPhoneShaken,
    this.shakeTimeMS = 500,
    this.shakeThresholdGravity = 3.25,
    this.shouldVibrate = true,
    this.vibrateDuration = 500,
  });

  /// Starts listening to accerelometer events
  void startListening() {
    streamSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
      var now = DateTime.now().millisecondsSinceEpoch;
      if ((now - _lastTime) > shakeTimeMS) {
        double x = event.x;
        double y = event.y;
        double z = event.z;
        double acceleration = sqrt(x * x + y * y + z * z) - 9.8;
        if (acceleration > shakeThresholdGravity) {
          if (shouldVibrate) Vibration.vibrate(duration: vibrateDuration);
          _lastTime = now;
          onPhoneShaken!();
        }
      }
    });
  }

  /// Stops listening to accelerometer events
  void stopListening() {
    streamSubscription!.cancel();
  }
}



/// Platform-independent vibration methods.
class Vibration {
  /// Method channel to communicate with native code.
  static const MethodChannel _channel = MethodChannel('vibration');

  /// Check if vibrator is available on device.
  ///
  /// ```dart
  /// if (await Vibration.hasVibrator()) {
  ///   Vibration.vibrate();
  /// }
  /// ```
  static Future hasVibrator() => _channel.invokeMethod("hasVibrator");

  /// Check if the vibrator has amplitude control.
  ///
  /// ```dart
  /// if (await Vibration.hasAmplitudeControl()) {
  ///   Vibration.vibrate(amplitude: 128);
  /// }
  /// ```
  static Future hasAmplitudeControl() =>
      _channel.invokeMethod("hasAmplitudeControl");

  /// Check if the device is able to vibrate with a custom
  /// [duration], [pattern] or [intensities].
  /// May return `true` even if the device has no vibrator.
  ///
  /// ```dart
  /// if (await Vibration.hasCustomVibrationsSupport()) {
  ///   Vibration.vibrate(duration: 1000);
  /// } else {
  ///   Vibration.vibrate();
  ///   await Future.delayed(Duration(milliseconds: 500));
  ///   Vibration.vibrate();
  /// }
  /// ```
  static Future hasCustomVibrationsSupport() =>
      _channel.invokeMethod("hasCustomVibrationsSupport");

  /// Vibrate with [duration] at [amplitude] or [pattern] at [intensities].
  ///
  /// The default vibration duration is 500ms.
  /// Amplitude is a range from 1 to 255, if supported.
  ///
  /// ```dart
  /// Vibration.vibrate(duration: 1000);
  ///
  /// if (await Vibration.hasAmplitudeControl()) {
  ///   Vibration.vibrate(duration: 1000, amplitude: 1);
  ///   Vibration.vibrate(duration: 1000, amplitude: 255);
  /// }
  /// ```
  static Future<void> vibrate(
      {int duration = 500,
        List<int> pattern = const [],
        int repeat = -1,
        List<int> intensities = const [],
        int amplitude = -1}) =>
      _channel.invokeMethod(
        "vibrate",
        {
          "duration": duration,
          "pattern": pattern,
          "repeat": repeat,
          "amplitude": amplitude,
          "intensities": intensities
        },
      );

  /// Cancel ongoing vibration.
  ///
  /// ```dart
  /// Vibration.vibrate(duration: 10000);
  /// Vibration.cancel();
  /// ```
  static Future<void> cancel() => _channel.invokeMethod("cancel");
}