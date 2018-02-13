//: [Previous](@previous)

/*
 # Structs
 Las estructuras tienen dos ventajas sobre las tuplas:
 
 - Los componentes SIEMPRE tienen nombrecomponentes
 - Pueden tener métodoscomponentes
 
 */

struct Complex { // Número complejo
    let x: Double // parte real
    let y: Double // parte imaginaria
    
    // Inicializador
    init(real: Double, imaginary: Double) {
        x = real
        y = imaginary
    }
    
    init(real: Double) {
        self.init(real: real, imaginary: 0)
    }
    
    init(imaginary: Double) {
        self.init(real: 0, imaginary: imaginary)
    }
    
    func magnitude() -> Double {
        return ( (x*x) + (y*y) ).squareRoot()
    }
}

let a = Complex(real: 3, imaginary: -4)

let b = Complex(real: 9)

let c = Complex(imaginary: 23)

// En Swift TODO es una struct (Int, Double, etc, etc)

//: STRUCT & INMUTABILIDAD
// Por defecto, todo en una struct es inmutable

struct Point {
    var x: Double
    var y: Double
    
    mutating func moveTo(x: Double, y: Double) { // Para permitir que una función de la struct modifique a la propia struct
        self.x = x // Self porque el nombre de los argumentos sobrescribe al de las propiedades
        self.y = y
    }
}

var point = Point(x: 12, y: 9)
point.x
point.y

point.moveTo(x: 0, y: 0)
point.x
point.y

//: Las structs nunca se comparten (entre dos variables). Es una de las
//: Principales diferencias con las clases

var x1: Int = 23
var x2 = x1

x1 = 0
x2


//: Las instancias en las clases, sin embargo, si se comparten

/*:
    Las structs NO tienen herencia
 
    Con las structs usaríamos PROTOCOLS
*/

// Son INMUTABLES por defecto

//: [Next](@next)
