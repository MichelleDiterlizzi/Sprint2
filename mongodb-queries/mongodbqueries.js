/*1 Escriu una consulta per mostrar tots els documents en la col·lecció Restaurants.

db.restaurants.find()


2 Escriu una consulta per mostrar el restaurant_id, name, borough i cuisine de tots els documents en la col·lecció Restaurants.

db.restaurants.find({},{"restaurant_id":1, "name":1, "borough":1, "cuisine":1})


3 Escriu una consulta per mostrar el restaurant_id, name, borough i cuisine, però excloent el camp _id per tots els documents en la col·lecció Restaurants.

db.restaurants.find({},{"restaurant_id":1, "name":1, "borough":1, "cuisine":1, "_id":0})


4 Escriu una consulta per mostrar restaurant_id, name, borough i zip code, però excloent el camp _id per tots els documents en la col·lecció Restaurants.

db.restaurants.find({},{"restaurant_id":1, "name":1, "borough":1, "cuisine":1, "address.zipcode":1, "_id":0})


5 Escriu una consulta per mostrar tots els restaurants que estan en el Bronx.

db.restaurants.find({"borough": "Bronx"}, {"name": 1, "borough":1, "_id":0})


6 Escriu una consulta per mostrar els primers 5 restaurants que estan en el Bronx.

db.restaurants.find({"borough": "Bronx"}, {"name": 1, "borough":1, "_id":0}).limit(5)


7 Escriu una consulta per mostrar els 5 restaurants després de saltar els primers 5 que siguin del Bronx.

db.restaurants.find({"borough": "Bronx"}, {"name": 1, "borough":1, "_id":0}).skip(5).limit(5)


8 Escriu una consulta per trobar els restaurants que tenen algun score més gran de 90.

db.restaurants.find({"grades.score": {"$gte": 90, $lte: 30}},{"name" : 1, "grades.score":1, "_id": 0})


9 Escriu una consulta per trobar els restaurants que tenen un score més gran que 80 però menys que 100.

db.restaurants.find({"grades.score": {"$gte": 80, $lte: 100}},{"name" : 1, "grades.score":1, "_id": 0})


10 Escriu una consulta per trobar els restaurants que estan situats en una longitud inferior a -95.754168.

db.restaurants.find({"address.coord.0": {"$lt":-95.754168}},{"name":1, "address.coord":1, "_id":0})


11 Escriu una consulta de MongoDB per a trobar els restaurants que no cuinen menjar 'American ' i tenen algun score superior a 70 i latitud inferior a -65.754168.

db.restaurants.find({"cuisine":{"$ne": "American "}, "grades.score": {$gt:70}, "address.coord.1":{$lt: -65.754168}},{"name":1, "address.coord":1, "cuisine":1, "grades.score":1, "_id":0})


12 Escriu una consulta per trobar els restaurants que no preparen menjar 'American' i tenen algun score superior a 70 i que, a més, es localitzen en longituds inferiors a -65.754168. Nota: Fes aquesta consulta sense utilitzar operador $and.

db.restaurants.find({"cuisine":{"$ne": "American "}, "grades.score": {$gt:70}, "address.coord.1":{$lt: -65.754168}},{"name":1, "address.coord":1, "cuisine":1, "grades.score":1, "_id":0})


13 Escriu una consulta per trobar els restaurants que no preparen menjar 'American ', tenen alguna nota 'A' i no pertanyen a Brooklyn. S'ha de mostrar el document segons la cuisine en ordre descendent.

db.restaurants.find({"cuisine": {"$ne": "American "}, "grades.grade": "A", "borough": {$ne: "Brooklyn"}}, {"name": 1, "cuisine": 1, "grades.grade": 1, "borough": 1, "_id": 0})


14 Escriu una consulta per trobar el restaurant_id, name, borough i cuisine per a aquells restaurants que contenen 'Wil' en les tres primeres lletres en el seu nom.

db.restaurants.find({"name":/^Wil/},{"restaurant_id":1, "name":1, "borough":1, "cuisine":1, "_id":0})


15 Escriu una consulta per trobar el restaurant_id, name, borough i cuisine per a aquells restaurants que contenen 'ces' en les últimes tres lletres en el seu nom.

db.restaurants.find({"name":/ces$/},{"restaurant_id":1, "name":1, "borough":1, "cuisine":1, "_id":0})

16 Escriu una consulta per trobar el restaurant_id, name, borough i cuisine per a aquells restaurants que contenen 'Reg' en qualsevol lloc del seu nom.

db.restaurants.find({"name":/ces/i},{"restaurant_id":1, "name":1, "borough":1, "cuisine":1, "_id":0})


17 Escriu una consulta per trobar els restaurants que pertanyen al Bronx i preparen plats Americans o xinesos.

db.restaurants.find({
    "borough": "Bronx", 
    "$or":[
        {"cuisine":"American "},
        {"cuisine": "Chinese"}
    ]}, 
    {"name":1, "borough":1, "cuisine":1, "_id":0})


18 Escriu una consulta per trobar el restaurant_id, name, borough i cuisine per aquells restaurants que pertanyen a Staten Island, Queens, Bronx o Brooklyn.

db.restaurants.find({"borough": {"$in":["Staten Island", "Queens", "Bronx", "Brooklyn"]}},{"restaurant_id":1, "name":1, "borough":1, "cuisine":1, "_id":0})


19 Escriu una consulta per trobar el restaurant_id, name, borough i cuisine per a aquells restaurants que NO pertanyen a Staten Island, Queens, Bronx o Brooklyn.

db.restaurants.find({"borough": {"$nin":["Staten Island", "Queens", "Bronx", "Brooklyn"]}},{"restaurant_id":1, "name":1, "borough":1, "cuisine":1, "_id":0})


20 Escriu una consulta per trobar el restaurant_id, name, borough i cuisine per a aquells restaurants que aconsegueixin una nota menor que 10.

db.restaurants.find({"grades.score": {"$lt": 10}},{"restaurant_id":1, "name":1, "borough":1, "cuisine":1, "_id":0})


21 Escriu una consulta per trobar el restaurant_id, name, borough i cuisine per a aquells restaurants que preparen marisc ('seafood') excepte si són 'American ', 'Chinese' o el name del restaurant comença amb lletres 'Wil'.

db.restaurants.find({
    "cuisine": "Seafood",
    "$nor": [
        {"cuisine": {"$in": ["American ", "Chinese"]}},
        {"name": {"$regex": "^Wil"}}
    ]},
    {"restaurant_id":1, "name":1, "borough":1, "cuisine":1, "_id":0})


22 Escriu una consulta per trobar el restaurant_id, name i grades per a aquells restaurants que aconsegueixin un grade de "A" i un score d'11 amb un ISODate "2014-08-11T00:00:00Z".


db.restaurants.find({
    "grades":{
        "$elemMatch": {
        "grade": "A",
        "score": 11,
        "date": ISODate("2014-08-11T00:00:00Z")}}},
    {"restaurant_id":1, "name":1, "grades":1, "_id":0})


23 Escriu una consulta per trobar el restaurant_id, name i grades per a aquells restaurants on el 2n element de l'array de graus conté un grade de "A" i un score 9 amb un ISODate "2014-08-11T00:00:00Z".

db.restaurants.find({
    "grades.1":{
        "grade": "A",
        "score": 9,
        "date": ISODate("2013-06-11T00:00:00.000+00:00")}},
    {"restaurant_id":1, "name":1, "grades":1, "_id":0})


24 Escriu una consulta per trobar el restaurant_id, name, adreça i ubicació geogràfica per a aquells restaurants on el segon element de l'array coord conté un valor entre 42 i 52.

db.restaurants.find({
    "address.coord.1": { "$gte": 42, "$lte": 52 }},
    {"restaurant_id":1, "name":1, "address":1, "_id":0})


25 Escriu una consulta per organitzar els restaurants per nom en ordre ascendent.

db.restaurants.find({}, { "name": 1, "_id": 0 }).sort({ "name": 1 });

26 Escriu una consulta per organitzar els restaurants per nom en ordre descendent.

db.restaurants.find({}, { "name": 1, "_id": 0 }).sort({ "name": -1 });


27 Escriu una consulta per organitzar els restaurants pel nom de la cuisine en ordre ascendent i pel barri en ordre descendent.

db.restaurants.find({}, { "name": 1, "_id": 0 }).sort({ "name": 1, "borough": -1 });


28 Escriu una consulta per saber si les direccions contenen el carrer.

db.restaurants.find({"address.street": { "$exists":true }}, { "name": 1, "_id": 0 });


29 Escriu una consulta que seleccioni tots els documents en la col·lecció de restaurants on els valors del camp coord és de tipus Double.

db.restaurants.find({"address.coord": { "$type": "double" }}, { "name": 1, "_id": 0 });


30 Escriu una consulta que seleccioni el restaurant_id, name i grade per a aquells restaurants que retornen 0 com a residu després de dividir algun dels seus score per 7.

db.restaurants.find({"grades.score": { "$mod": [7,0] }}, { "restaurant_id" : 1, "name": 1, "grades.grade": 1, "_id": 0 });


31 Escriu una consulta per trobar el name de restaurant, borough, longitud, latitud i cuisine per a aquells restaurants que contenen 'mon' en algun lloc del seu name.

db.restaurants.find({"name": /mon/i }, { "name": 1, "address.coord": 1, "borough": 1, "cuisine" : 1, "_id": 0 });


32 Escriu una consulta per trobar el name de restaurant, borough, longitud, latitud i cuisine per a aquells restaurants que contenen 'Mad' com a primeres tres lletres del seu name.

db.restaurants.find({"name": /^Mad/ }, { "name": 1, "address.coord": 1, "borough": 1, "cuisine" : 1, "_id": 0 });

*/