'use strict';

const persona = {
    name: 'Luis',
    surname: 'Gomez',
    sayName: function() {
        console.log(this.name + ' ' + this.surname);
    }
    };

// En el momento de ejecutarlo, lo que tenga a la izquierda del punto será this 
persona.sayName(); // Luis Gomez

// setTimeout es el que la ejecuta, y al ejecutarla no va a tener a persona como "this"
setTimeout(persona.sayName, 3000); // undefined undefined

// con bind "pegamos el objeto" a la función en su this
setTimeout(persona.sayName.bind(persona), 3000); // Luis Gomez

// otro ejemplo de bind
const saluda = persona.sayName.bind(persona);
saluda();