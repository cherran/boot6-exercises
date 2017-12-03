var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
// app.set('view engine', 'ejs');
app.set('view engine', 'html'); // Para utilizar ejs pero usando la extensión de archivo .html en las plantillas para mantener el syntax highlighting
app.engine('html', require('ejs').__express);


// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false })); // ojo con el formato!! (al leer parámetros del body de la petición)
app.use(cookieParser());


// --------------------------------------------------- ejemplos de middleware

app.use('/saludo', function (req, res, next) {
  console.log(req.originalURL);
  res.send('hola'); // devuelvo la petición
})

app.use('/', function (req, res, next) {
  // Si un middleware no devuelve una respuesta debe llamar al siguiente middleware (next())
  next();
})


// cargamos nuestras rutas
// establecemos un middleware determinado (route) que responda a nuestra petición
app.use('/', require('./routes/index'));
app.use('/users', require('./routes/users'));

// aquí está mejor puesto
app.use(express.static(path.join(__dirname, 'public'))); // para todo lo que haya en la carpeta public lo sirva como ficheros estáticos

// catch 404 and forward to error handler
// ----> no ha encontrado ningún middleware que atienda la petición recibida
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});



// err = new Error('hgsadhgsagjhfwgf'); algún middleware crea un error así y el siguiente middleware lo captura
// error handler
app.use(function(err, req, res, next) {
  // errores de validación (express-validator)
  if(err.array) {
    err.status = 422; // status code 422 --> error de validación
    const errInfo = err.array({ onlyFirstError: true})[0];
    err.message = `Not valid - ${errInfo.param} ${errInfo.msg}`
  }
  
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
