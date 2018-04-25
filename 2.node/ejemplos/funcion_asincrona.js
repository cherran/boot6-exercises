
function escribeTras2Segundos(texto, callback) {
  setTimeout(function() {
    console.log(texto);
    callback();
  }, 2000);
}

// Así se ejectuan las dos a la vez, ocurren en paralelo

/* escribeTras2Segundos('hola', function() { //este es el callback
    console.log('he terminado');
})

escribeTras2Segundos('hola2', function() { //este es el callback
    console.log('he terminado2');
}) */

// Así se ejecutan en serie:
escribeTras2Segundos('hola', function() { //este es el callback
    escribeTras2Segundos('hola2', function() { //este es el callback
        console.log('he terminado');
    })
})

console.log('Mientras esperas voy haciendo otra cosa');