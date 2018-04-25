//: [Previous](@previous)  : [Next](@next)
//: # Clausuras

//: ## Toda Clausura es una función y toda función es un clausura

//: Las funciones (clausuras) capturan el entorno lexico donde han sido creadas

let answer = 42

func iSeeYourAnwser(_ n: Int) -> Int{
    // Puede ver lo definido anteriormente a su definición
    return n + answer
}

iSeeYourAnwser(0)
iSeeYourAnwser(2)


func iHideYourAnswer(_ n: Int) -> Int{
    // A no ser que en el entorno de la función, "ocultemos" el
    // símbolo externo. A esto se le llama "hacer sombra" (shadow):
    // la constante más interna le hace sombra a la externa
    let answer = -1
    return n + answer
}

iHideYourAnswer(0)
iHideYourAnswer(answer + 1)




//: ## Funciones dentro de funciones

//: Podemos declarar funciones dentro de funciones. La función interna captura
//: el entorno léxico de la función externa.
//: Una función que *fabrica* otras funciones:
typealias IntToInt = (Int) -> Int

func adder(n: Int) -> IntToInt{
    
    func f(x: Int) -> Int {
        return x + n
    }
    
    return f
}

adder(n:8)
adder(n: 42)(8)

let g = adder(n: 42)
g(8)


//: ## Funciones como parámetros de otras funciones

//: No sólo podemos devolver funciones, sino que las podemos aceptar también como parámetros
// Funciones como parámetros de entrada
// "Función memorizadora -> Investigar"
func apply(f: IntToInt, n: Int) -> Int{
    return f(n)
}

apply(f: g, n: 99)




//: ## Sintaxis de clausura

//: Cuando se habla de *clausura* en `Swift`, en realidad se habla de una sintaxis especial,
//: ya que toda función es en realidad una clausura.
//: Cuando se usa la sintaxis de clausura, se declara una función (o clausura) como
//: cualquier otro tipo de `Swift`.

//: Un *objeto* función encasquetado en una variable

var f = { (n: Double) -> Double in  // Lo que viene después de *in* es el cuerpo de la función.
    let m = (n * Double.pi)
    return 2 * m / (n + 1)
}

f(8.99)

//: Cuando declaras una función de forma *normal*, como ésta
func h(_ n: Int)->Int{
    return 5 + n
}

//: Lo que el compilador *ve* **en realidad** es esto:

let hh = { (n:Int) -> Int in return 5 + n }

// Es exactamente lo mismo
h(2)
hh(2)

//: ## Funciones en Colecciones (como cualquier otro tipo)

//: las funciones al ser tipos como culaquier otro,
//: se pueden meter en colecciones, siempre y cuando tengan el mismo tipo

let functions = [h, hh, g]

for function in functions{
    dump(function(23)) // Para 'debugear' variables, da bastante información del objeto
}





//: La sintaxis abreviada de clausuras
let clausuras = [h, // El primero tiene que ser con toda la información para que se pueda inferir bien
                { (n: Int) in return n + 1 },    // 100% explícita
                { n in return n * 3 },           // el tipo del parámetro se infiere
                { n in n * 6 },  // Si el cuerpo solo tiene una linea, no hace falta return
                { $0 * 9 }      // No hace falta el nombre del parámetro (sólo su posición)
]
// La sintáxis ultra-minimalista, se usa mucho en Swift, especialmente como


// clausuras de finalización: usese, callbacks
let evens = [6,12,2,8,4,10]

evens.sorted(by: { (a: Int, b: Int) in a > b })


//: sintaxis de la clausura que cuelga
evens.sorted { (a: Int, b: Int) -> Bool in
    return (a > b)
}




//: ## Los grandes clásicos de la FP (Programación funcional)
//: Operaciones sobre colecciones con programación funcional
//: Clásicos de FP: map, filter, flatMap

var result = [Int]()
for element in evens{
    result.append(element * 4)
}
result

//: Map: iteración para chuck norris
result = evens.map {$0 * 4}
result

// Filter: elimina ciertos elementos de un array
result = evens.filter {$0 > 6}
result

// FlatMap: un map que se salta los niles (Uso deprecado de flatMap!! -> En este caso es )
let intsOrNil : [Int?] = [1,2, nil, 4, 7, nil]
let rc = intsOrNil.flatMap {$0?.byteSwapped}
rc

let limpioDeNiles = intsOrNil.flatMap {$0}



//: ## Trailing Closure o "la clausura que cuelga"

//: Es muy común que una función tenga como último parámetro una clausura. Dicha clausura sirve para indicarle a la función *qué debe de hacer una vez que haya terminado*. Se le llama *completion closure* y es un mecanismo de comunicación que cada vez es más común en Cocoa. Es totalmente equivalente a los *callbacks* de `Node.js`
/*: A los mecanismos de comunicación que ya conocíamos en Cocoa, ahora se añade un más, quedando así la lista:
 
 * Target / Action
 * Delegate
 * Notifications
 * *Closures*
 
 Posteriormente, vereis otra forma más de enviar información dentro de una App: La Programación Funcional Reactiva que vereis en Super Poderes.
 
 ### Sintaxis especial
 
 Como es tan común, tiene una sintaxis especial que vereis muy a menudo.
 */


typealias Task = () -> ()
func doSomething(n: Int, completion: Task){
    // do something fancy with n
    
    // Once you're finished, call the completion closure
    completion()
}

// Se le puede llamar así, en plan normal
doSomething(n: 42, completion: { print("De forma normal") })

// O así, en plan "trailing closure" la clausura que cuelga
doSomething(n: 42) {
    print("de otra forma")
    // Y si quisiera imprimir el parámetro n de doSomething, ¿podría?
}

//: [Next](@next)









