import 'package:flutter/services.dart';

class RingtoneService {
  static const MethodChannel _channel = MethodChannel('ringtone');

 Future<String?> getDefaultRingtone() async {
  try {
    final String? result =
        await _channel.invokeMethod('getDefaultRingtone');
    return result;
  } on PlatformException catch (e) {
    print("Error: ${e.message}");
    return null;
  }
}

}
