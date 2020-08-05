package com.example.gps_background.service

import android.content.Context
import android.content.IntentFilter
import androidx.localbroadcastmanager.content.LocalBroadcastManager

class ServiceStarter(
        private val context: Context
) {
    private val broadcastReceiver = LocationBroadcastReceiver()

    fun startService() {
        LocalBroadcastManager
                .getInstance(context)
                .registerReceiver(broadcastReceiver, IntentFilter(LocationService.BROADCAST_ACTION))
    }
}