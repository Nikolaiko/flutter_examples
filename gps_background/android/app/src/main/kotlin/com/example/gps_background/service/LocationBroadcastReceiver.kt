package com.example.gps_background.service

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.location.Location
import com.example.gps_background.LocationUpdateCallback

class LocationBroadcastReceiver(
    private val callback: LocationUpdateCallback
): BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        val location = intent.getParcelableExtra<Location>(LocationService.EXTRA_LOCATION)
        if (location != null) {
            val locationMap = HashMap<String, Double>()
            locationMap["latitude"] = location.latitude
            locationMap["longitude"] = location.longitude
            locationMap["altitude"] = location.altitude
            locationMap["accuracy"] = location.accuracy.toDouble()
            locationMap["bearing"] = location.bearing.toDouble()
            locationMap["speed"] = location.speed.toDouble()
            locationMap["time"] = location.time.toDouble()
            callback(locationMap)
        }
    }
}