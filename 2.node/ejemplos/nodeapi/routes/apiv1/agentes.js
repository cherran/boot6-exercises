'use strict';

const express = require('express');
const router = express.Router();
const basicAuth = require('../../lib/basicAuth');
const jwtAuth = require('../../lib/jwtAuth');

// cargar el modelo de Agente
const Agente = require('../../models/Agente');

// Basic auth para todas las rutas definidas en el router
// router.use(basicAuth(
//   process.env.BASIC_AUTH_USER,
//   process.env.BASIC_AUTH_PASSWORD));

// JWT auth
router.use(jwtAuth());

/**
  * GET /agentes
  * Obtener una lista de agentes
  */
router.get('/', async (req, res, next) => {
  // buena idea utilizar try-catch dentro de una función async para capturar errores en las funciones await
  try {
    // se deberían introducir validaciones con express validator
    const name = req.query.name;
    const age = req.query.age;
    const limit = parseInt(req.query.limit);
    const skip = parseInt(req.query.skip)
    const sort = req.query.sort;
    const fields = req.query.fields; 

    // creo el filtro vacío
    const filter = {};

    if(name) {
      filter.name = name;
    }

    if (age) {
      filter.age = age;
    }

    const rows = await Agente.list(filter, limit, skip, sort, fields); // el exec() de la query nos la devuelve en forma de promesa
    res.json({ success: true, result: rows });
  } catch (err) {
    next(err);
  }
});


/**
 * GET /agentes:id
 * Obtener un agente
 */
router.get('/:id', async (req, res, next) => {
  const _id = req.params.id;
  try {
    const agente = await Agente.findOne({ _id: _id }); // _id: _id === _id
    res.json({ success: true, result: agente });
  } catch (err) {
    next(err);
  }
});


/**
 * POST /agentes
 * Crea un agente
 */
router.post('/', (req, res, next) => {
  // creamos un agente en memoria
  const agente = new Agente(req.body);

  // lo persistimos en la colección de agentes
  agente.save((err, agenteGuardado) => {
    if (err){
      next(err);
      return;
    }
    res.json({ success: true, result: agenteGuardado });
  })
});


/**
 * PUT /agentes
 * Actualiza un agente
 */
router.put('/:id', async (req, res, next) => {
  try {
    const _id = req.params.id;
    const data = req.body;
    // { new: true }: para que devuelva el nuevo agente editado, y no el antiguo que ha sido editado
    const agenteActualizado = await Agente.findOneAndUpdate({ _id: _id }, data, { new: true }).exec();
    res.json({ success: true, result: agenteActualizado });
  } catch (err) {
    next(err);
  }
});


/**
 * DELETE /agentes
 * Elimina un agente
 */
router.delete('/:id', async (req, res, next) => {
  try {
    const _id = req.params.id;
    await Agente.remove({_id}).exec();
    res.json({ success: true});
  } catch (err) {
    next(err);
  }
});
  
module.exports = router;