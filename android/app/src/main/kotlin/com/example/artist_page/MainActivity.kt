package com.example.artist_page

import android.database.ContentObserver
import android.os.Handler
import android.os.Looper
import android.provider.MediaStore
import android.content.Context
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.screenshot/detection"

    override fun configureFlutterEngine(flutterEngine: io.flutter.embedding.engine.FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Register the platform channel for communication
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            // You can handle other method calls from Flutter here if needed
        }

        // Register ContentObserver for MediaStore to detect screenshots
        contentResolver.registerContentObserver(
            MediaStore.Images.Media.EXTERNAL_CONTENT_URI,
            true,
            ScreenshotObserver(Handler(Looper.getMainLooper()))
        )
    }

    // Inner class to detect screenshots using ContentObserver
    inner class ScreenshotObserver(handler: Handler) : ContentObserver(handler) {
        override fun onChange(selfChange: Boolean) {
            super.onChange(selfChange)

            // Notify Flutter when a screenshot is taken, checking if flutterEngine is non-null
            flutterEngine?.dartExecutor?.binaryMessenger?.let { messenger ->
                MethodChannel(messenger, CHANNEL).invokeMethod("onScreenshotTaken", null)
            }
        }
    }
}