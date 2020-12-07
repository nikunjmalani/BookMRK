package com.solutioncone.bookmrk

import android.content.Intent
import android.os.Bundle
import com.easebuzz.payment.kit.PWECouponsActivity
import com.google.gson.Gson
import datamodels.PWEStaticDataModel
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject
import java.util.*

//import io.flutter.plugins.GeneratedPluginRegistrant;

//import io.flutter.plugins.GeneratedPluginRegistrant;
class MainActivity : FlutterActivity() {
    private var channel_result: MethodChannel.Result? = null
    var start_payment = true
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

//        GeneratedPluginRegistrant.registerWith(this);
        start_payment = true
        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            channel_result = result
            if (call.method == "payWithEasebuzz") {
                if (start_payment) {
                    start_payment = false
                    startPayment(call.arguments)
                }
            }
        }
    }

    private fun startPayment(arguments: Any) {
        try {
            val gson = Gson()
            val parameters = JSONObject(gson.toJson(arguments))
            val intentProceed = Intent(baseContext, PWECouponsActivity::class.java)
            val amount: Float = parameters.getString("amount").toFloat()
            intentProceed.putExtra("txnid", parameters.optString("txnid"))
            intentProceed.putExtra("amount", amount)
            intentProceed.putExtra("productinfo", parameters.optString("productinfo"))
            intentProceed.putExtra("firstname", parameters.optString("firstname"))
            intentProceed.putExtra("email", parameters.optString("email"))
            intentProceed.putExtra("phone", parameters.optString("phone"))
            intentProceed.putExtra("s_url", parameters.optString("s_url"))
            intentProceed.putExtra("f_url", parameters.optString("f_url"))
            intentProceed.putExtra("key", parameters.optString("key"))
            intentProceed.putExtra("udf1", parameters.optString("udf1"))
            intentProceed.putExtra("udf2", parameters.optString("udf2"))
            intentProceed.putExtra("udf3", parameters.optString("udf3"))
            intentProceed.putExtra("udf4", parameters.optString("udf4"))
            intentProceed.putExtra("udf5", parameters.optString("udf5"))
            intentProceed.putExtra("address1", parameters.optString("address1"))
            intentProceed.putExtra("address2", parameters.optString("address2"))
            intentProceed.putExtra("city", parameters.optString("city"))
            intentProceed.putExtra("state", parameters.optString("state"))
            intentProceed.putExtra("country", parameters.optString("country"))
            intentProceed.putExtra("zipcode", parameters.optString("zipcode"))
            intentProceed.putExtra("hash", parameters.optString("hash"))
            intentProceed.putExtra("pay_mode", parameters.optString("pay_mode"))
            intentProceed.putExtra("unique_id", parameters.optString("unique_id"))
            startActivityForResult(intentProceed, PWEStaticDataModel.PWE_REQUEST_CODE)
        } catch (e: Exception) {
            println("test exception ==" + e.message)
            start_payment = true
            val error_map: MutableMap<String, Any> = HashMap()
            val error_desc_map: MutableMap<String, Any> = HashMap()
            val error_desc = "exception occured:" + e.message
            error_desc_map["error"] = "Exception"
            error_desc_map["error_msg"] = error_desc
            error_map["result"] = PWEStaticDataModel.TXN_FAILED_CODE
            error_map["payment_response"] = error_desc_map
            channel_result!!.success(error_map)
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent) {
        if (requestCode == PWEStaticDataModel.PWE_REQUEST_CODE) {
            start_payment = true
            val response = JSONObject()
            val error_map: MutableMap<String, Any?> = HashMap()
            if (data != null) {
                val result = data.getStringExtra("result")
                val payment_response = data.getStringExtra("payment_response")
                try {
                    val obj = JSONObject(payment_response)
                    response.put("result", result)
                    response.put("payment_response", obj)
                    channel_result!!.success(JsonConverter.convertToMap(response))
                } catch (e: Exception) {
                    val error_desc_map: MutableMap<String, Any?> = HashMap()
                    error_desc_map["error"] = result
                    error_desc_map["error_msg"] = payment_response
                    error_map["result"] = result
                    error_map["payment_response"] = error_desc_map
                    channel_result!!.success(error_map)
                }
            } else {
                val error_desc_map: MutableMap<String, Any> = HashMap()
                val error_desc = "Empty payment response"
                error_desc_map["error"] = "Empty error"
                error_desc_map["error_msg"] = error_desc
                error_map["result"] = PWEStaticDataModel.TXN_FAILED_CODE
                error_map["payment_response"] = error_desc_map
                channel_result!!.success(error_map)
            }
        } else {
            super.onActivityResult(requestCode, resultCode, data)
        }
    }

    companion object {
        private const val CHANNEL = "easebuzz"
    }
}
