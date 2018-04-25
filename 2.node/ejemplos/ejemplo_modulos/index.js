'use strict';

const pagos = require('./pagos');
const pagos2 = require('./pagos');
// Siempre que hacemos un require del mismo módulo 

console.log(pagos.APIKEY);

pagos.pagar(500);
pagos.APIKEY = 'apikey cambiado'

console.log(pagos2.APIKEY);