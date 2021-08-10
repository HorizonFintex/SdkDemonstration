package com.horizonfintex.sampleAndroid

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.webkit.WebView
import android.widget.Button
import android.widget.LinearLayout

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val btnShowCreateKey = findViewById<Button>(R.id.btnShowCreateKey)
        val btnShowSignMsg = findViewById<Button>(R.id.btnShowSignMsg)

        btnShowCreateKey.setOnClickListener {
            val intent = Intent()
            intent.setClass(this, CreateKeyStore::class.java)
            startActivity(intent)
        }

        btnShowSignMsg.setOnClickListener {
            val intent = Intent()
            intent.setClass(this, SignMessage::class.java)
            startActivity(intent)
        }
    }
}