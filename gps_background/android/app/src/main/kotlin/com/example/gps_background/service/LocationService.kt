package com.example.gps_background.service

import android.app.Service
import android.content.Intent
import android.os.IBinder

class LocationService: Service() {
    companion object {
        const val BROADCAST_ACTION = "location_update_broadcast"
    }

    override fun onBind(p0: Intent?): IBinder? {
        TODO("Not yet implemented")
    }
}