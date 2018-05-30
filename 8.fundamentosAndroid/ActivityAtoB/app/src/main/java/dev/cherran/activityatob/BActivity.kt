package dev.cherran.activityatob

import android.content.Context
import android.content.Intent
import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import kotlinx.android.synthetic.main.activity_b.*

class BActivity : AppCompatActivity() {

    companion object {
        val EXTRA_NUMBER = "EXTRA_NUMBER"
        val EXTRA_STRING = "EXTRA_STRING"

        fun intent(context: Context, number: Int, string: String): Intent {
            // Creamos el Intent
            val intent = Intent(context, BActivity::class.java)

            // Le pasamos datos al Intent
            intent.putExtra(EXTRA_NUMBER, number)
            intent.putExtra(EXTRA_STRING, string)

            // Devolvemos el intent preparado para que nos llamen
            return intent
        }
    }

    val number by lazy {
        intent.getIntExtra(EXTRA_NUMBER, 0)
    }

    val string by lazy {
        intent.getStringExtra(EXTRA_STRING)
    }


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_b)

        // Leo los datos recibidos en el Intent para iniciar esta actividad
//        val number = intent.getIntExtra(EXTRA_NUMBER, 0)
//        val string = intent.getStringExtra(EXTRA_STRING)

        result.text = "He recibido esto: ${string}, ${number}"

    }
}
