'use strict';

const EventEmitter = require('events');

// creamos un emisor de eventos
const emisor = new EventEmitter();

emisor.on('llamar telefono', sonarTelefono);
emisor.on('llamar telefono', vibrarTelefono);

// con once sólo nos suscribimos a la primera vez que salta el evento
emisor.once('llamar telefono', vibrarTelefono);

function sonarTelefono(quien) {
    if (quien === 'madre') {
        return;
    }
    console.log('ring ring');
}

function vibrarTelefono() {
    console.log('brr brr');
}

// emitimos el evento
emisor.emit('llamar telefono');

// emitimos el evento
emisor.emit('llamar telefono', 'madre');

process.stdin.on('data', function (data) {
    console.log('He recibido', data.toString());
})