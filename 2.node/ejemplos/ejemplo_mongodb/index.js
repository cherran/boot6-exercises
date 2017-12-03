'use strict';

// ES6 destructuing
// const { MongoClient } = require('mongodb'); // Parece que con esto no funciona el intellisense
const MongoClient = require('mongodb').MongoClient;

MongoClient.connect('mongodb://localhost/cursonode', (err, db) => {
  if (err) {
    console.log('Error connecting!!!!!', err);
    process.exit(1);
  }
  db.collection('agentes').find().toArray((err, docs) => {
    if (err) {
      console.log('Error!!!!!', err);
      process.exit(1);
    }
    console.log(docs);
    db.close((err) => {
      if (err) {
        console.log('Error closing database!!!!!', err);
      } else {
        console.log('mongodb connection closed');
      }
    })
  })
});

