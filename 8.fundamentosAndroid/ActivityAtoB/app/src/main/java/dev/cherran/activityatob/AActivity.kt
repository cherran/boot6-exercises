package dev.cherran.activityatob

import android.support.v7.app.AppCompatActivity
import android.os.Bundle
import kotlinx.android.synthetic.main.activity_a.*

class AActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_a)

        aButton.setOnClickListener {
            // Vamos a la actividad B con datos
            val intent = BActivity.intent(
                    this,
                    42,
                    "La respuesta al sentido de la vida, el universo y todo lo demás"
            )

            startActivity(intent)
        }
    }
}
