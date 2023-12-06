package com.example.flutter_application_1

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
import android.content.ContentResolver
import android.content.Context
import android.media.Ringtone
import android.media.RingtoneManager
import android.net.Uri

private fun getDefaultRingtone(context: Context): String {
    val contentResolver: ContentResolver = context.contentResolver
    val defaultRingtoneUri: Uri = RingtoneManager.getDefaultUri(RingtoneManager.TYPE_RINGTONE)
    val defaultRingtone: Ringtone = RingtoneManager.getRingtone(context, defaultRingtoneUri)
    return defaultRingtone.getTitle(context).toString()
}
MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "ringtone")
    .setMethodCallHandler { call, result ->
        if (call.method == "getDefaultRingtone") {
            val defaultRingtone = getDefaultRingtone(this)
            result.success(defaultRingtone)
        } else {
            result.notImplemented()
        }
    }

}
