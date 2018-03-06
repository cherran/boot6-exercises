

//: Funciones como valores de retorno de otra función

//func adder (n: Int) -> ((Int) -> Int) {
//
//}

typealias IntToInt = (Int) -> Int
// Nota mía: parecen las arrow functions de javascript
// Función que recibe un Int y devuelve un Int

func adder (n: Int) -> IntToInt {
    
    func f(x: Int) -> Int {
        return x + n
    }
    
    // f captura el entorno léxico de adder2 (todo lo que utiliza la misma)
    return f
}


let h = adder(n: 32)
h(1)

let g = adder(n: 100)
g(10)


// Funciones con parámetros de entrada (de otra función):

func apply(f: IntToInt, n: Int) -> Int {
    return f(n)
}

apply(f: h, n: 12)


// Toda función de swift es, en realidad, una clausura
// Puede acceder a todo lo que se haya definido previamente: capturar el entorno léxico

// Sintaxis de clausura
func f(_ n: Int) -> Int {
    return n + 1
}

// Esto es equivalente a: (lo que hace el compilador po debajo)
let f1 = { (n: Int) in
    return n + 1
}

f(8)
f1(8)


// Metemos funciones dentro de un Array (tienen que ser todas del mismo tipo (argumentos y return))
let functions = [f, f1, h, g]

for fn in functions {
    fn(42)
}


// La sintaxis abreviada de closures
let closures = [
    f, // 100% explícita
    {(n: Int) -> Int in return n + 1 }, // 100% explícita
    { n in return n + 1 }, // No hace falta especificar el tipo de entrada, lo infiere.
    { n in n * 3 }, // Sie el cuerpo sólo tiene una línea, no hace falta el return
    { $0 + 1} // No hace falta el nombre del parámetro
]

// La sintaxis ultra-minimalista se usa mucho en Swift, sobre todo en las clausuras de finalización
let evens = [6, 12, 2, 8, 4, 10]

var array = evens.sorted(by: { (a: Int, b: Int) -> Bool in a > b }) // sorted(by: (Int, Int) throws -> Bool)
print(array)

func ordenar(a: Int, b: Int) -> Bool {
    return a < b
}

array = evens.sorted(by: ordenar)
print(array)

array = evens.sorted(by: { (a: Int, b: Int) in a > b })
print(array)

array = evens.sorted(by: { a, b in a > b })
print(array)

array = evens.sorted(by: { $0 > $1 }) // solo especificando los argumentos por su orden
print(array)

// La clausura que cuelga (trailimg closure)
array = evens.sorted {
    $0 < $1
}
print(array)

array = evens.sorted { a, b in
    a < b
}
print(array)
// Y así sucesivamente hacia arriba (más explícito)




//: Operación sobre colecciones con PROGRAMACIÓN FUNCIONAL
// Clásicos de FP: map, flatMap, filter, reduce




// .................................. MAP
// Recibe una colleción y una función que se aplica a cada uno de los elementos
// Iteración para Chuck Norris

// Programación imperativa
var results = [Int]()
for element in evens {
    results.append(element * 2)
}
print(evens)
print(results)

// Se puede hacer mejor con MAP
results = evens.map { $0 * 2 }

let resultsString =
    evens.map { $0 * 2 }
         .map { String($0)}

print(resultsString)



// .................................. FILTER
// Recibe un filtro y devuelve un Bool

// Imperativa
results = []
for element in evens {
    if element > 6 {
        results.append(element)
    }
}
print(results)

// Funcional
results = []
results = evens.filter { $0 > 6}
print(results)



// .................................. FLATMAP
// es un map que se salta los niles

let intOrNil: [Int?] = [6, nil, nil, 12, 2, nil, 8, 4, nil, 10]

let res = intOrNil.flatMap { $0 }
print(res)

// limpiar nil
// * 2
// String

let other = intOrNil
    .flatMap { $0 }
    .map{ $0 * 2 }
    .map { String($0)}
    .map { "Hola \($0)" }
print(other)



//: REDUCE

let array2 = [1,2,3,4,5]

// Imperativa
var sum: Int = 0
for element in array {
    sum = sum + element
}

// Funcional
let result = array.reduce(0) { element in
    res + element
}






