'use strict';

// patrón factory, función que retorna un objeto haciendo closures, para no tener que utilizar this

function creaAgente(nombre) {
    return {
        getNombre: function() {
            return nombre;
        },
        setNombre: function () {
            nombre = valor;
        },
        saluda: function() {
            console.log('Hola soy', nombre);
        }
    }
}

const jones = creaAgente('Jones');
jones.saluda();

const smith = creaAgente('Smith');
smith.saluda();

// Cada función crearAgente guarda su propio contexto (variable nombre)

setTimeout(jones.saluda, 2000);   
setTimeout(smith.saluda, 2000);