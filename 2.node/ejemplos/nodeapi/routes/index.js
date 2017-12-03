var express = require('express');
var router = express.Router();

// Sacar valores directamente de un objeto (de sus propiedades) ---------> ES6 destruturing
const { query, validationResult } = require('express-validator/check');

// Sería lo mismo que hacer esto
// const check = require('express-validator/check');
// const query = check.query;
// const validationResult = check.validationResult;

/* GET home page. */
router.get('/', function(req, res, next) {

  const segundo = (new Date()).getSeconds();
  
  res.locals.valor = '<script>alert("inyección de código!!!")<script>'
  res.locals.condicion = {
    segundo: segundo,
    estado: (segundo % 2 === 0) // si el segundo es par
  }
  res.locals.users = [
      { name: 'Smith', age: 22 },
      { name: 'Thomas', age: 32 },
      { name: 'Jones', age: 27 },
    
  ];

  res.render('index', { title: 'Express' });
});

// Recibiendo parámetros en la ruta
router.get('/paramenruta/:dato', function (req, res, next) {
  console.log('req.params es', req.params);
  res.send('OK, recibido ' + req.params.dato);
});

router.get('/paramenrutaopcional/:dato?', function (req, res, next) {
  console.log('req.params es', req.params);
  res.send('OK, recibido ' + req.params.dato);
});

router.get('/paramenruta/:dato', function (req, res, next) {
  console.log('req.params es', req.params);
  res.send('OK, recibido ' + req.params.dato);
});

// [0-9]+ --> uno o más dígitos entre 0 y 9
router.get('/param/:id([0-9]+)/piso/:piso/puerta/:puerta', (req, res, next) => {
  console.log('req.params es', req.params);
  res.send('OK, recibido ' + req.params.id);
});


// recibiendo parámetros en query-string
router.get('/paramenquery', [
  query('age').isNumeric().withMessage('must be numeric!')
],(req, res, next) => {
  console.log('req.query', req.query)
  ////////////////////////////////////////////// los parámetros leidos siempre son string

  validationResult(req).throw(); // Si hay un error, que haga un throw de la excepción
  res.send('OK');
});

// recibiendo los parámetros en el body de la petición
router.put('/paramenbody', (req, res, next) => {
  console.log('body', req.body); // body
  
  // Para leer parámetros de los headers
  const contentType = req.get('Content-Type');

  res.send('OK, parámetros en body: ' + JSON.stringify(req.body) + '\nContent-Type header: ' + contentType);
});


module.exports = router;
