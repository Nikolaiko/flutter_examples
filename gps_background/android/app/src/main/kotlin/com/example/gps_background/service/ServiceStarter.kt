package com.example.gps_background.service

import android.content.*
import android.os.Build
import android.os.IBinder
import androidx.localbroadcastmanager.content.LocalBroadcastManager
import com.example.gps_background.LocationUpdateCallback
import io.flutter.plugin.common.MethodChannel

class ServiceStarter(
        private val context: Context,
        private val callback: LocationUpdateCallback
) {
    private var alreadyBinded: Boolean = false
    private var bindedService: LocationService? = null

    private val serviceConnection = object : ServiceConnection {
        override fun onServiceConnected(name: ComponentName, service: IBinder) {
            println("Binded")
            alreadyBinded = true

            val binder = service as LocationService.LocalBinder
            bindedService = binder.service
            bindedService?.requestLocationUpdates()
        }

        override fun onServiceDisconnected(name: ComponentName) {
            bindedService = null
        }
    }

    private val broadcastReceiver = LocationBroadcastReceiver {
        callback(it)
    }

    init {
        LocalBroadcastManager.getInstance(context).registerReceiver(broadcastReceiver,
                IntentFilter(LocationService.BROADCAST_ACTION))
    }

    fun startService() {
        LocalBroadcastManager.getInstance(context).registerReceiver(broadcastReceiver,
                IntentFilter(LocationService.BROADCAST_ACTION))

        if (!alreadyBinded) {
            val serviceIntent = Intent(context, LocationService::class.java)
            context.bindService(serviceIntent, serviceConnection, Context.BIND_AUTO_CREATE)
        }
    }

    fun stopService() {
        LocalBroadcastManager.getInstance(context).unregisterReceiver(broadcastReceiver)
        bindedService?.removeLocationUpdates()

        if (alreadyBinded) {
            context.unbindService(serviceConnection)
            alreadyBinded = false
        }
    }
}