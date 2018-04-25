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
    // reject('No queda ajo')
  });
}

function conMejillones (plato) {
  return plato + ' mejillones';
}

function con(plato, ingrediente) {
  return new Promise((resolve, reject) => {
    resolve(plato + ' ' + ingrediente);
  });
}

const paella = 'paella con';

// encadenar las funciones que devuelven promesas
async function main() {
  
  // aquí podrñe utilizar await
  let plato = await conArroz(paella);

  // la siguiente linea se ejecutará cuando se resuelva la promesa
  plato = await conAjo(plato);
  
  for (let i = 0; i < 5; i++) {
    plato = await con(plato, 'pollo');    
  }

  plato = await conMejillones(plato);

  console.log('El resultado es: ', plato)
}

main().catch(err => {
  console.log('Hubo un fallo:', err);
});


// conArroz(paella)
// .then(conAjo)
// .then(conAjo)
// .then(plato => {
//   // retornar una promesa para que siga la cadena
//   return con(plato, 'pollo');
//   // const promesa = con(plato, 'pollo');
//   // return promesa;
// })
// .then(plato => {
//   console.log('plato:', plato);
// }).catch(err => {
//   // este catch se activa si falla cualquiera de las promesas anteriores
//   console.log('Hubo un fallo:', err);
// });

