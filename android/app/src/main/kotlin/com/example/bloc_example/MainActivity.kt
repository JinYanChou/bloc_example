package com.example.bloc_example

import android.widget.Toast
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        val channel = MethodChannel(flutterEngine.dartExecutor, "com.example.bloc_example/alert")
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "show" -> {
                    Toast.makeText(this, "測試一下訊息", Toast.LENGTH_SHORT).show()
                    result.success("Hello, ${call.arguments}")
                }
                else -> result.notImplemented()
            }
        }
    }
}
