package com.horizonfintex.sampleAndroid

import android.app.AlertDialog
import android.app.Dialog
import android.content.DialogInterface
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.text.TextUtils
import android.util.Log
import android.widget.Button
import android.widget.LinearLayout
import android.widget.TextView
import com.google.android.material.textfield.TextInputEditText
import com.horizonfintex.sdk.EtherumKit.EthereumCreator
import com.horizonfintex.sdk.EtherumKit.EthereumOperator
import kotlin.jvm.internal.Intrinsics

class CreateKeyStore : AppCompatActivity() {
    var ethOperator: EthereumOperator? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_create_key_store)


        val rootContainer = findViewById<LinearLayout>(R.id.rootContainer)
        val btnCreateKey = findViewById<Button>(R.id.btnCreateKeystore)
        val tvPwd = findViewById<TextInputEditText>(R.id.edtKeyPwd)
        val tvKeystoreContent = findViewById<TextView>(R.id.tvKeystoreContent)

        this.ethOperator = EthereumCreator.createOperator(this, rootContainer)

        btnCreateKey.setOnClickListener {
            val pwdStr = tvPwd.text.toString()

            if (TextUtils.isEmpty(pwdStr)) {
                showErrorDialog("Please enter password")
                return@setOnClickListener
            }

            this.ethOperator!!.generateKeystore(pwdStr) { keystore, error ->
                Log.d("MainActivity", "keystore: ${keystore?.keystoreStr}")
                tvKeystoreContent.text = keystore?.keystoreStr
            }
        }
    }

    private fun showErrorDialog(message: String) {
        val dialog = AlertDialog
                .Builder(this)
                .setTitle("Error")
                .setMessage(message)
                .setPositiveButton("Ok", DialogInterface.OnClickListener { _, _ ->  })
                .create()

        dialog.show()
    }


}