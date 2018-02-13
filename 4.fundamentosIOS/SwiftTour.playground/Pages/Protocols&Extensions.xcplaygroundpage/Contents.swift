//: [Previous](@previous)

/*:
 
 EXTENSION -> es como una categoría en Objective-C
 
 Mecanismo para:
    a) Añadir funcionalidad a una clase o struct pre-existente
    b) Modularizar clases/structs
    c) Implementación por defecto de protocols
 
 */


// MARK: - Int
extension Int {
    func invert() -> Int {
        return -self
    }
    
    var double: Double { // Computed Property
        return Double(self) // por defecto es el getter (ver más abajo)
    }
}

42.invert()
-8.invert().double


//: ¿Qué cosas no se pueden añadir a una extensión?
//: Nada que pueda cambiar el layout del objeto --> propiedades!!! (pregunta de entrevista)

// Esto no se puede hacer (stored property)
//extension Int {
//    var a: Double
//}

//: Tampoco se pueden añadir ciertos tipos de init (init designados)

// (internal), public, private, fileprivate
struct Complex {
    let x: Double
    let y: Double
}

extension Complex {
    var magnitude: Double { // las variables computadas tienen get y set.
        get {
            return ( (x * x) + (y * y)).squareRoot()
        }
//        set {
//            newValue
//        }
    }
}

let complex = Complex(x: 2, y: 4)
complex.magnitude


/*
 PROTOCOLS: Muy similar a los interfaces de Java o los protocols de Objective-C
 Swift -> lenguaje orientado a protocols
 
 Obligatorio mirarse los siguientes:
 
 - CustomStringConvertible
 - Equatable
 - Hashtable
 - Comparable
 
 */

extension Complex: CustomStringConvertible { // Implementa el protocolo CustomStringConvertible
    var description: String {
        return "\(x) + \(y)j"
    }
}

complex.description
print(complex)


extension Complex: Equatable {
    static func ==(lhs: Complex, rhs: Complex) -> Bool {
        return (lhs.x, lhs.y) == (rhs.x, rhs.y)
    }
}

let complex2 = Complex(x: 8, y: -3)

complex == complex
complex == complex2

// Deficición de un protocolo
protocol Answerable {
    var answer: Int { get } // read only
    
    func sayHello() -> String
}

// IMPLEMENTACIÓN POR DEFECTO: se tiene que hacer en una extensión sobre el protocolo
extension Answerable {
    var answer: Int {
        return 42
    }
    
    func sayHello() -> String {
        return "Hello"
    }
}

// A partir de ahora, cualquier tipo que adopte el protocolo Answerable tendrá esa opción por defecto
extension String:Answerable {}

let question = "What is the meaning of life?"
question.answer

extension Complex:Answerable {
    var answer: Int {
        return 8
    }
}
complex.answer
complex.sayHello()




//: [Next](@next)
