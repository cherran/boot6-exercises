'use strict';

var express = require('express');
var router = express.Router();

const jwt = require('jsonwebtoken');

router.post('/', (req, res, next) => {
  // recogemos las credenciales
  const email = req.body.email;
  const password = req.body.password;
  console.log(email, password)
  // Buscamos en la base de datos el usuario
  // ...
  // simulamos que buscamos
  if (email != 'user@example.com' || password != '1234') {
    res.status = 401;
    res.json({ error: 'Credenciales incorrectas'});
    return;
  }

  const user = { _id: '534hg54sdfhsa564sh'};
  console.log(user);

  // si el usuario existe y la password coincide 
  // creamos un token 
  // (al firmarlo mejor no hacerlo con el user entero, ya que es más lento y...)
  // no firmar objetos de mongoose, usar mejor un nuevo objeto solo con lo mínimo
  jwt.sign(user, process.env.JWT_SECRET, {
    expiresIn: process.env.JWT_EXPIRES_IN
    }, (err, token) => {
      if (err) {
      next(err);
      return;
    }

    // y lo devolvemos (el token)
    res.json({token: token});
  });
});

module.exports = router;