package com.example.media_player

import android.os.Build
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.NonNull
import android.Manifest
import android.content.pm.PackageManager
import androidx.core.app.ActivityCompat

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        requestPermissions()
    }

    private fun requestPermissions() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            ActivityCompat.requestPermissions(this, arrayOf(
                Manifest.permission.READ_MEDIA_AUDIO
            ), 1)
        } else if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            ActivityCompat.requestPermissions(this, arrayOf(
                Manifest.permission.MANAGE_EXTERNAL_STORAGE
            ), 1)
        } else {
            ActivityCompat.requestPermissions(this, arrayOf(
                Manifest.permission.READ_EXTERNAL_STORAGE,
                Manifest.permission.WRITE_EXTERNAL_STORAGE
            ), 1)
        }
    }
}
