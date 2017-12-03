'use strict';

// constructor de objetos de tipo Persona
function Persona(nombre) {
    this.nombre = nombre;
    /* de esta forma sería menos eficiente, ya que se crea la función para cada objeto de tipo Persona 
    this.saluda = function() {
        console.log('Hola, me llamo', this.nombre)
    } */
}

// construir un objeto de tipo persona
const luis = new Persona("Luis");

// añadir propiedades y métodos al prototipo de las personas

Persona.prototype.saluda = function() {
    console.log('Hola, me llamo', this.nombre)
}

luis.saluda();

const pedro = new Persona('Pedro');

pedro.saluda();


// Herencia de Pesona() -----------------------------------------------------------

function Agente(name) {
    Persona.call(this, name); // heredamos constructor de personas
}

// heredamos las propiedades y métodos del prototipo
Agente.prototype = new Persona('soy un prototipo'); // heredaría name y saluda()

const smith = new Agente('Smith');

smith.saluda();

console.log(smith.nombre, "es una instancia de Agente:", smith instanceof Agente)
console.log(smith.nombre, "es una instancia de Agente:", smith instanceof Agente)



// Herencia Múltiple --------------------------------------------------------------

// Mixin Superheroe
function Superheroe() {
    this.vuela = function () {
        console.log(this.nombre, 'vuela')
    }
    this.esquivaBalas = function () {
        console.log(this.nombre, 'esquiva balas')
    }
}

// copiamos todas las propiedades de Superheroe al prototipo de Agente
Object.assign(Agente.prototype, new Superheroe());

smith.vuela();
smith.esquivaBalas();





