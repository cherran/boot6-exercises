'use strict;'

// cargamos el driver de MySQL
const mysql = require('mysql');

// crear una conexión
const conexion = mysql.createConnection({
    host: 'didimo.es',
    user: 'usuariocurso',
    password: 'us3r',
    database: 'cursonode'  
});

// establecemos conexión
conexion.connect();
// no utilizamos un callback ya que el driver de mysql se encarga de controlar eso
// (no lanza las consultas hasta que la bbdd no está conectada)


// lanzamos una consulta
conexion.query('SELECT * FROM agentes', (err, rows, fields) => { // convención --> pasar el error como primer parámetro del callback
    if (err) { // convención
        console.log('Hubo un error:', err);
        process.exit(1);
    }

    for (let i = 0; i < rows.length; i++) {
        const agente = rows[i];
        console.log(agente.idagentes, agente.name, agente.age);
    }
    
    // cerramos la conexión
    conexion.end();
});