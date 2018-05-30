package dev.cherran.activitybtoa

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import kotlinx.android.synthetic.main.activity_b.*

class BActivity : AppCompatActivity() {
    companion object {
        val EXTRA_NUMBER = "EXTRA_NUMBER"
        val EXTRA_STRING = "EXTRA_STRING"

        /*fun intent(context: Context): Intent {
            return Intent(context, BActivity::class.java)
        }*/

        // equivalente abreviada de este método (se puede hacer así en Kotlin para métodos de pocas líneas)
        fun intent(context: Context) = Intent(context, BActivity::class.java)

    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_b)

        cancel_btn.setOnClickListener {
            setResult(Activity.RESULT_CANCELED)
            finish()
        }

        accept_btn.setOnClickListener {
            val returnIntent = Intent()
            returnIntent.putExtra(EXTRA_NUMBER, 42)
            returnIntent.putExtra(EXTRA_STRING, "La respuesta del universo y todo lo demás")

            setResult(Activity.RESULT_OK, returnIntent)

            finish()
        }
    }
}
