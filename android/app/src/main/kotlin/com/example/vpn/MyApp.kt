package com.example.vpn

import android.app.Application
import io.maido.intercom.IntercomFlutterPlugin

/**
 * Description:
 * Author: Jack Zhang
 * create on: 2025/4/13 19:13
 */
class MyApp : Application() {
    override fun onCreate() {
        super.onCreate()

        // Initialize the Intercom SDK here also as Android requires to initialize it in the onCreate of
        // the application.
        IntercomFlutterPlugin.initSdk(this, appId = "nloyidtl", androidApiKey = "android_sdk-6845f71340f327cc291287033ff5a333a51dfe0a")
    }
}