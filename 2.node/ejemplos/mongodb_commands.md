
### Show existing databases
```
show dbs
```

### Select a database
```
use [database_name]
```

### Find (select) from a collection
```
db.agentes.find()
```

### Find (select) from a collection (pretty and indented)
```
db.agentes.find().pretty()
```

```json
> db.agentes.find().pretty()
{
        "_id" : ObjectId("5a25a7a82dc899e549bae2c4"),
        "name" : "Smith",
        "age" : 32
}
{
        "_id" : ObjectId("5a25a8582dc899e549bae2e4"),
        "name" : "Brown",
        "age" : 47
}
{
        "_id" : ObjectId("5a25a8f22dc899e549bae2f8"),
        "name" : "Jones",
        "age" : 23
}
{
        "_id" : ObjectId("5a25ac955879c84ee9ebe0c8"),
        "name" : "otro",
        "age" : 27,
        "hair" : "blonde"
}
```

### Insert document
```
db.agentes.insert({name: "otro"}, age: 27, hair: "blonde"})
```

### Remove document
```
// ObjectId(...) solo en la consola
db.agentes.remove({ _id: ObjectId("5a25a8f22dc899e549bae2f8")})
```

### Update document (ojo con el $set!! Para modificar propiedades concretas del documento)
```
db.agentes.update( { _id: ObjectId("5a25ac955879c84ee9ebe0c8") }, { $set: {name: "Jones"} })
```

### Delete database/collection
```
drop db.collection
```

### Create index
```
// Por name descendente y por age ascendente --> para mejorar búsquedas por name
db.agentes.createIndex({name:1, age:-1})
```

### Show indexes in the collection
```
db.agentes.getIndexes()
```

[More info](https://docs.mongodb.com/manual/reference/mongo-shell/)
### Filtering find() results
```js
db.agentes.find({ name : 'Smith'})

db.agentes.find({ _id : ObjectId("55eadb4191233838648570de")}) 

db.agentes.find({ age: { $gt: 30}}) // $lt, $gte, $lte, ... (greater than, less than, greater or equal than...)

db.agentes.find({ age: { $gt: 30, $lt: 40}});

db.agentes.find({ name: { $in: [ 'Jones', 'Brown']}}) //$nin 

db.agentes.find({ name: 'Smith', $or: [
  { age: { $lt: 30}},
  { age: 43 } // 'Smith' and ( age < 30 or age = 43)
] })
```



### Subdocuments (an object as a property)
```
db.agentes.find({ 'producer.company': 'ACME'})
```

### Arrays
```
db.agentes.find({ bytes: [ 5, 8, 9 ]}) // array exact
db.agentes.find({ bytes: 5}) // array contains (in any position)
db.agentes.find({ 'bytes.0': 5}) // array position (array contains 5 in position 0)
```

### More filtering info:

http://docs.mongodb.org/manual/reference/method/db.collection.find/#db.collection.find
http://docs.mongodb.org/manual/tutorial/query-documents/

### Order:
```
db.agentes.find().sort({age: -1}) 
```

### Discard results:
```
db.agentes.find().skip(1).limit(1)
db.agentes.findOne({name: 'Brown'}) // igual a limit(1)
```

### Contar:
```
db.agentes.find().count() // db.agentes.count()
```


### Full Text Search
#### Crear índice por los campos de texto involucrados:
`db.agentes.createIndex({title: 'text', lead: 'text', body: 'text'});`

#### Para hacer la búsqueda usar:
`db.agentes.find({$text:{$search:'smith jones'});`

#### Frase exacta:
`db.agentes.find({$text:{$search:'smith jones "el elegido"'});`

####Excluir un término:
`db.agentes.find({$text:{$search:'smith jones -mister'});`

#### More info:
`https://docs.mongodb.com/v3.2/text-search/`
`https://docs.mongodb.com/v3.2/tutorial/specify-language-for-text-index/`


### MongoDB Geo
Es necesario crear un índice geoespacial.
[More info](https://docs.mongodb.com/manual/applications/geospatial-indexes/)
```
db.productos.createIndex({location: '2dsphere'})
db.productos.insert({
  "location": {
    "coordinates":[ -73.856077, 40.848447 ], // longitude, latitude
    "type": "Point"
  }
})
```

To find nearby documents (example):
```
const meters = parseFloat(req.params.meters); // 105 * 1000 const longitude = parseFloat(req.params.lng); // -73
const latitude = parseFloat(req.params.lat); // 40
     db.productos.find({
       location: {
         $nearSphere: {
           $geometry: {
             type: 'Point',
coordinates: [longitude, latitude] },
$maxDistance: meters }
} })
```

### MongoDB transactions
findAndModify es una operación atómica, lo que nos dará un pequeño respiro transaccional.
```
db.agentes.findAndModify({
    query: { name: "Brown"},
    update: { $inc: { age: 1}}
})
```
Lo busca y si lo encuentra lo modifica, no permitiendo que otro lo cambie antes de modificarlo.