"use strict";

function escribeTras2Segundos(texto, callback) {
    setTimeout(function() {
      console.log(texto);
      callback();
    }, 2000);
}


// bucle asíncrono en serie
// llamar a una función asíncrona procesando un array en serie
function serie(arr, fun, callbackFinalizador) {
    if (arr.length == 0) {
        callbackFinalizador();
        return;
    }
    
    fun('texto' + arr.shift(), function () { // quito el primer elemento del array
        serie(arr, fun, callbackFinalizador);
    } )
}

serie([1,2,3,4,6], escribeTras2Segundos, function () {
    console.log('He terminado');
})