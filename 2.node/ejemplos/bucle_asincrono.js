"use strict";

function escribeTras2Segundos(texto, callback) {
    setTimeout(function() {
      console.log(texto);
      callback();
    }, 2000);
}

// bucle en paralelo
/* for (let i = 0; i < 5; i++) {
    escribeTras2Segundos('texto'+ i, function () {
        console.log('he terminado ' + i);
    } )
} */

// bucle asíncrono en serie
// llamar a una función asíncrona n veces en serie
function serie(n, fun, callbackFinalizador) {
    if (n === 0) {
        callbackFinalizador();
        return;
    }
    n = n - 1;
    fun('texto' + n, function () {
        serie(n, fun, callbackFinalizador);
    } )
}

serie(5, escribeTras2Segundos, function () {
    console.log('He terminado');
})
