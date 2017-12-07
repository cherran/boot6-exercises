'use strict';

// Funciones que devuelven promesas

function conArroz(plato) {
  return new Promise((resolve, reject) => {
    resolve(plato + ' arroz');
    // reject(new Error('no queda ajo'));
  });
}

function conAjo(plato) {
  return new Promise((resolve, reject) => {
    resolve(plato + ' ajo');
  });
}

function con(plato, ingrediente) {
  return new Promise((resolve, reject) => {
    resolve(plato + ' ' + ingrediente);
  });
}

const paella = 'paella con';

// encadenar las funciones que devuelven promesas
conArroz(paella)
.then(conAjo)
.then(conAjo)
.then(plato => {
  // retornar una promesa para que siga la cadena
  return con(plato, 'pollo');
  // const promesa = con(plato, 'pollo');
  // return promesa;
})
.then(plato => {
  console.log('plato:', plato);
}).catch(err => {
  // este catch se activa si falla cualquiera de las promesas anteriores
  console.log('Hubo un fallo:', err);
});

