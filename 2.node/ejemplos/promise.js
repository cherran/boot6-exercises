'use strict';

// función que retorna una promesa
function sleep(ms) {
  return new Promise((resolve, reject) => {
    // aquí va el código que hará resolverse o rechazarse la promesa
    setTimeout(() => {
      resolve('Promesa resuelta :)');
      // reject(new Error('fatal'));
    }, ms);   
  });
}

// consumir la promesa
const promesa = sleep(2000);

// en el then() definimos la fuinción resolve de la promesa
promesa.then( (data) => {
  console.log('la promesa se completó:', data);
}).catch(err => {
  // en el catch() definimos l afunción reject de la proomesa
  console.log('promesa rechazada:', err);
});
