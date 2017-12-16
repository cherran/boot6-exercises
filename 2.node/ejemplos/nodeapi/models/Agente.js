'use strict';

const mongoose = require('mongoose');

// primero creamos el esquema
// Ojo, aquí se definen también índices
const agenteSchema = mongoose.Schema({
  // unique hace que no se puedan repetir 'names' en la colección
  name: { type: String, index: true, unique: true },
  age: Number,
});

// De manera automática, mongoose elige la colección donde guarda el modelo, quitando la
// mayúscula y pluralizando el nombre (Agente --> agentes). Si queremos ponerlo manualmente:
// const agenteSchema = mongoose.Schema({...}, { collection: "agents" });

// Creamos un método estático del modelo
// todo el código que hagamos en el modelo va a ser reutilizable
agenteSchema.statics.list = function(filters, limit, skip, sort, fields) {
  // obtenemos la query sin ejecutarla
  const query = Agente.find(filters);
  console.log(limit);
  query.limit(limit);
  query.skip(skip); // Cuantos registros se tiene que saltar para empezar a devolverme datos
  query.sort(sort);
  query.select(fields); // Para elegir las propiedades determinadas que queremos que nos devuelva
  // ejecutamos la query y devolvemos una promesa
  return query.exec(); // así devuelve la query en forma de promesa
}


// Crear un  método de instancia del modelo 
agenteSchema.methods.findSimilarAges = (callback) => {
  return this.model('Agente').find({ age: this.age }, callback)
}


// después creamos el modelo
const Agente = mongoose.model('Agente', agenteSchema); 

// y por último lo exportamos
module.exports = Agente;
