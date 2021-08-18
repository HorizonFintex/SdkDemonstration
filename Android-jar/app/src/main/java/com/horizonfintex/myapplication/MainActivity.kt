package com.horizonfintex.myapplication

import android.os.Bundle
import android.util.Log
import com.google.android.material.floatingactionbutton.FloatingActionButton
import com.google.android.material.snackbar.Snackbar
import androidx.appcompat.app.AppCompatActivity
import android.view.Menu
import android.view.MenuItem
import com.horizonfintex.sdk.EthereumKit.EthereumCreator
import com.horizonfintex.sdk.EthereumKit.EthereumKeystore
import com.horizonfintex.sdk.EthereumKit.EthereumOperator

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        setSupportActionBar(findViewById(R.id.toolbar))

        findViewById<FloatingActionButton>(R.id.fab).setOnClickListener { view ->
            Snackbar.make(view, "Replace with your own action", Snackbar.LENGTH_LONG)
                    .setAction("Action", null).show()
        }

        val keystoreStr = "{\"address\":\"d7e3064a1072232325f374043dc09795d1eb70df\",\"crypto\":{\"cipher\":\"aes-128-ctr\",\"ciphertext\":\"717305985bb93f64298b7ad416be3a461f43184ad92864ceca217a205f4450f7\",\"cipherparams\":{\"iv\":\"3ed9de100027cdfa2d4efa29f8bda3d0\"},\"kdf\":\"scrypt\",\"kdfparams\":{\"dklen\":32,\"n\":262144,\"p\":1,\"r\":8,\"salt\":\"5b605d5ffc6628362246217e0b1f2ad0f45128e7afde4fda8adbaca2c6be1f82\"},\"mac\":\"2dd8f22e3efd48eb7cb1ac7c9ce42d2d014ae70b57aa176e45f34196f73fdba2\"},\"id\":\"f6cd9817-ce38-49d8-a80a-398938253039\",\"version\":3}"
        val keystore = EthereumKeystore(keystoreStr)
        val operator = EthereumCreator.createOperator()
        operator.signMessage("0xa734dfa607e04b1ebe6b2cf6b74d0192fdc6ec1b", keystore, "Hi!123432!!D", "hello world") { result, error ->
            Log.d("MainActivity", result)
        }
    }

    override fun onCreateOptionsMenu(menu: Menu): Boolean {
        // Inflate the menu; this adds items to the action bar if it is present.
        menuInflater.inflate(R.menu.menu_main, menu)
        return true
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        return when (item.itemId) {
            R.id.action_settings -> true
            else -> super.onOptionsItemSelected(item)
        }
    }
}