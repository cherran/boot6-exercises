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

// Creamos un método estático
agenteSchema.statics.list = function(filters, limit, skip, sort, fields) {
  // obtenemos la query sin ejecutarla
  const query = Agente.find(filters);
  query.limit(limit);
  query.skip(skip);
  query.sort(sort)
  query.select(fields);
  // ejecutamos la query y devolvemos una promesa
  return query.exec();
}


// después creamos el modelo
const Agente = mongoose.model('Agente', agenteSchema); 

// y por último lo exportamos
module.exports = Agente;
