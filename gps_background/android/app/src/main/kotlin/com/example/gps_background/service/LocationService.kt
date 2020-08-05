package com.example.gps_background.service

import android.annotation.SuppressLint
import android.app.Notification
import android.app.Service
import android.content.Intent
import android.location.Location
import android.os.*
import android.provider.ContactsContract.Directory.PACKAGE_NAME
import androidx.core.app.NotificationCompat
import androidx.localbroadcastmanager.content.LocalBroadcastManager
import com.google.android.gms.location.*

class LocationService: Service() {
    companion object {
        const val BROADCAST_ACTION = "location_update_broadcast"
        const val EXTRA_LOCATION = "location_from_notification"

        private val TAG = LocationService::class.java.simpleName
        private const val CHANNEL_ID = "channel_01"
        private const val EXTRA_STARTED_FROM_NOTIFICATION = "started_from_notification"
        private const val NOTIFICATION_ID = 12345678

        private const val UPDATE_INTERVAL_IN_MILLISECONDS: Long = 2000
        private const val FASTEST_UPDATE_INTERVAL_IN_MILLISECONDS = UPDATE_INTERVAL_IN_MILLISECONDS / 2
    }

    private var fusedLocationClient: FusedLocationProviderClient? = null
    private var locationCallback: LocationCallback? = null
    private var location: Location? = null
    private var locationRequest: LocationRequest? = null

    private val binder = LocalBinder()
    private val notification: Notification
        get() {
            val intent = Intent(this, LocationService::class.java)
            intent.putExtra(EXTRA_STARTED_FROM_NOTIFICATION, true)

            val builder = NotificationCompat.Builder(this)
                    .setContentTitle("Background service is running")
                    .setOngoing(true)
                    .setSound(null)
                    .setPriority(Notification.PRIORITY_HIGH)
                    .setWhen(System.currentTimeMillis())
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                builder.setChannelId(CHANNEL_ID)
            }
            return builder.build()
        }

    override fun onBind(p0: Intent?): IBinder? = binder

    override fun onCreate() {
        super.onCreate()

        fusedLocationClient = LocationServices.getFusedLocationProviderClient(this)
        locationCallback = object : LocationCallback() {
            override fun onLocationResult(locationResult: LocationResult?) {
                super.onLocationResult(locationResult)
                onNewLocation(locationResult!!.lastLocation)
            }
        }

        createLocationRequest()
        getLastLocation()

        startForeground(NOTIFICATION_ID, notification)
    }

    @SuppressLint("MissingPermission")
    fun requestLocationUpdates() {
        try {
            println("requestet")
            fusedLocationClient!!.requestLocationUpdates(
                    locationRequest,
                    locationCallback!!,
                    Looper.myLooper()
            )
        } catch (unlikely: SecurityException) {
            //Empty to process exception
        }
    }

    fun removeLocationUpdates() {
        try {
            fusedLocationClient!!.removeLocationUpdates(locationCallback!!)
            stopSelf()
            stopForeground(true)
        } catch (unlikely: SecurityException) {
            //Empty to process exception
        }

    }

    @SuppressLint("MissingPermission")
    private fun getLastLocation() {
        try {
            fusedLocationClient!!.lastLocation
                    .addOnCompleteListener { task ->
                        if (task.isSuccessful && task.result != null) {
                            location = task.result
                        }
                    }
        } catch (unlikely: SecurityException) {
            //Empty to process exception
        }

    }

    private fun onNewLocation(newLocation: Location) {
        location = newLocation
        val intent = Intent(BROADCAST_ACTION)
        intent.putExtra(EXTRA_LOCATION, location)
        LocalBroadcastManager.getInstance(applicationContext).sendBroadcast(intent)
    }

    private fun createLocationRequest() {
        locationRequest = LocationRequest()
        locationRequest?.interval = UPDATE_INTERVAL_IN_MILLISECONDS
        locationRequest?.fastestInterval = FASTEST_UPDATE_INTERVAL_IN_MILLISECONDS
        locationRequest?.priority = LocationRequest.PRIORITY_HIGH_ACCURACY
        locationRequest?.maxWaitTime = UPDATE_INTERVAL_IN_MILLISECONDS * 2
    }

    inner class LocalBinder : Binder() {
        internal val service: LocationService
            get() = this@LocationService
    }
}