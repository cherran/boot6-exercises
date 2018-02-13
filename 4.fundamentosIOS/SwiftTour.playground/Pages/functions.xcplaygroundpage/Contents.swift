// INTRO A FUNCIONES
func add(x: Int, y: Int) -> Int { // lo que va después de lsa flecha es el retorno de la función
    return x + y
}

add(x: 42, y: 5)
// Hay que especificar el nombre de los parámetros al llamar a la función

// Funciones con nombres externos e internos (parámetros)
func fractionOf (numerator n: Double, denominator d: Double) -> Double {
    return n / d
}

fractionOf(numerator: 45.2, denominator: 8)
// Si no especificas el nombre externo, este es el mismo que el interno

func add42(_ a: Int) -> Int {
    return a + 42
}

add42(4) // Podemos utilizar el símbolo anónimo para permitir llamar funciones sin los nombres de los parámetros

/*:
 # Crear nuevos tipos a partir de los ya existentes
 
 ## Nuevos Tipos
 
 - Tuplas
 - Struct
 - Classes
 - Enums
 
 */

//: ### Tuplas
// Listas de distintos tipos pegados uno detrás de otro
var httpResponse = ("OK", 200)
type(of: httpResponse)
// httpResponse = (200, "OK") ERROR!!


var httpResponse2: (String, Int) = ("Not found", 404)

// Cómo se acceden a los componentes de una tupla? Por posición

httpResponse.0
httpResponse2.1

// Devolver más de un valor con tuplas
func intDiv(_ a: Int, _ b: Int) -> (cociente: Int, resto: Int) {
    return ( (a / b), (a % b))
}

intDiv(9, 4)
intDiv(10, 4).resto


typealias HTTPStatus = (code: Int, text: String)
typealias HTTPRequest = String
typealias HTTPResponse = (body: String, status: HTTPStatus)

func httpServer(request: HTTPRequest) -> HTTPResponse {
    // Habría que poner el código de verdad
    return ("It worked", (200, "OK"))
}

let response = httpServer(request: "index.html")
dump(response) // como un print pero devuelve más información

//: Pattern Matching
// Se utiliza para "desensamblar" la tupla en varias variables

let (cociente, resto) = intDiv(5, 2)
dump(cociente)
dump(resto)

// Quiero extraer el code del status
let (_, status) = httpServer(request: "index.php")
dump(status)

//: TUPLAS DE N ELEMENTOS
//: a la tupla de N elementos se le llama n-tupla
(3, 5, "abc") // 3-tupla
(2,1) // 2-tupla
(4) // 1-tupla???? Pues no. Es el elemento en sí
() // 0-tupla, significa la nada. Como Void en otros lenguajes

func f (a: Int) {
    print(a)
}

func h (a: Int) -> () {
    print(a)
}

// Estas dos funciones son lo mismo (el compilador lo infiere)
























