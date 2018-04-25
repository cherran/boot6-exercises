
console.log('inicializo mi librería de pagos');


module.exports.APIKEY = 'gasf7a78sdc0ig3427fghcdo323';

module.exports.pagar = function (cantidad) {
    console.log('hemos pagado', cantidad);
}

// exports es un alias de module.exports
exports.devolver = function(cantidad) {
    console.log('hemos devuelto', devolver);
}


// exports = 5; // noooooo -> nos estamos cargando el alias exports 
// module.exports = 5 -> ok