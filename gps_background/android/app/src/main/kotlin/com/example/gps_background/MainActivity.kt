package com.example.gps_background

import com.example.gps_background.service.ServiceStarter
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    companion object {
        private const val CHANNEL_NAME = "native_channel"
    }

    private var channel: MethodChannel? = null
    private var serviceStarter: ServiceStarter? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        serviceStarter = ServiceStarter(context) {
            channel?.invokeMethod("locationCallback", it, null)
        }

        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_NAME)
        channel?.setMethodCallHandler { call, result ->
            when(call.method) {
                START_SERVICE -> {
                    println("Start")
                    serviceStarter?.startService()
                }
                STOP_SERVICE -> {
                    println("Stop")
                    serviceStarter?.stopService()
                }
                else -> { result.notImplemented() }
            }
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        serviceStarter?.stopService()
    }
}
