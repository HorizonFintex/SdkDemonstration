package com.horizonfintex.sampleAndroid

import android.app.AlertDialog
import android.content.DialogInterface
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.text.TextUtils
import android.widget.Button
import android.widget.LinearLayout
import android.widget.TextView
import com.google.android.material.textfield.TextInputEditText
import com.horizonfintex.sdk.EtherumKit.EthereumKeystore
import com.horizonfintex.sdk.EtherumKit.HGEthereumOperator
import com.horizonfintex.sdk.WebView.JSWebView

class SignMessage : AppCompatActivity() {
    var ethOperator: HGEthereumOperator? = null
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_sign_message)

        val rootContainer = findViewById<LinearLayout>(R.id.rootContainer)
        val tvKeystore = findViewById<TextInputEditText>(R.id.edtKeystore)
        val tvPwd = findViewById<TextInputEditText>(R.id.edtKeyPwd)
        val tvMsg = findViewById<TextInputEditText>(R.id.edtMsg)
        val tvContractAddr = findViewById<TextInputEditText>(R.id.edtContractAddr)
        val btnSign = findViewById<Button>(R.id.btnSignMsg)

        val jsEvaluator = JSWebView(this)
        this.ethOperator = HGEthereumOperator(jsEvaluator, rootContainer)


        btnSign.setOnClickListener {
            val keystoreStr = tvKeystore.text.toString().trim()
            val pwdStr = tvPwd.text.toString()
            val message = tvMsg.text.toString()
            val contractAddr = tvContractAddr.text.toString().trim()

            if (TextUtils.isEmpty(keystoreStr)) {
                showMessageDialog("Error","Please enter keystore")
                return@setOnClickListener
            }

            if (TextUtils.isEmpty(pwdStr)) {
                showMessageDialog("Error", "Please enter password")
                return@setOnClickListener
            }

            if (TextUtils.isEmpty(message)) {
                showMessageDialog("Error", "Please enter message")
                return@setOnClickListener
            }

            if (TextUtils.isEmpty(contractAddr)) {
                showMessageDialog("Error", "Please enter Contract address")
                return@setOnClickListener
            }

            val keystore = EthereumKeystore(keystoreStr)
            if (keystore == null) {
                showMessageDialog("Error", "You've entered invalid keystore,  please try again")
                return@setOnClickListener
            }

            this.ethOperator!!.signMessage(contractAddr, keystore, pwdStr, message) { result, error ->
                if (error != null) {
                    showMessageDialog("Error", error.message.toString())
                    return@signMessage
                }
                showMessageDialog("Signed Message", result!!)
            }
        }
    }


    private fun showMessageDialog(title: String, message: String) {
        val dialog = AlertDialog
            .Builder(this)
            .setTitle(title)
            .setMessage(message)
            .setPositiveButton("Ok", DialogInterface.OnClickListener { _, _ ->  })
            .create()

        dialog.show()
    }
}