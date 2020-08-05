package com.example.gps_background

import com.example.gps_background.service.ServiceStarter
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    companion object {
        private const val CHANNEL_NAME = "native_channel"
    }

    private val serviceStarter = ServiceStarter()

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_NAME).setMethodCallHandler { call, result ->
            when(call.method) {
                START_SERVICE -> {
                    serviceStarter.startService()
                }
                else -> { result.notImplemented() }
            }
        }
    }
}
