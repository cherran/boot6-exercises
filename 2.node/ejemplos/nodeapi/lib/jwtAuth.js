'use strict';

const jwt = require('jsonwebtoken');

// exportamos un creador de middlewares de autentificación

module.exports = () => {
  return function(req, res, next) {
    // leer token
    const token = req.body.token || req.query.token || req.get('x-access-token');

    if (!token) {
      const err = new Error('No token provided');
      err.status = 401;
      next(err);
      return;
    }

    // comprobar credenciales
    jwt.verify(token, process.env.JWT_SECRET, (err, decoded) => {
      if (err) {
        console.log('Token error:', err);
        const error = new Error('Invalid token');
        error.status = 401;
        next(error);
        return;
      }

      console.log('Decoded token:', decoded);
      // el token es válido, continuar
      // lo guardamos en el request para los siguientes middlewares
      req.userId = decoded._id;
      next();
    });
  }
}