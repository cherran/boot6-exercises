// Valores, Bindings & REPL
let answer = 42

// answer = 56 ERROR! Al utilizar let, creamos una constante que no puede ser modificada en el futuro

// Siempre es mejor let que var
var donnaMobile = "Soy una variable y puedo cambiar"
donnaMobile = "Cambié"

// donnaMobile = 80 //PROHIBIDO. Swift es un lenguaje de tipado fuerte y estático

// En Swift, podemos definir de forma explícita el tipo de una variable
var name: String = "Jon Snow"

// Hay información redundante. El compilador puede INFERIR (descubrir) el tipo el solo
// INFERENCDIA DE TIPOS:
var name2 = "Tyrion"

// Un alias para un tipo
// typealias NOMBRE_NUEVO = NOMBRE_VIEJO

typealias Integer = Int

import Foundation

let number: Integer = 8



typealias Author = String

let author: Author = "George Raymont Richard Marting"
print(author)

// Un typealias es un mote a un tipo

// El símbolo anónimo _

let _ = "Rob Stark"
let _ = "Stannis"

// Tanto Stannis como Robb se han ido al pedo
