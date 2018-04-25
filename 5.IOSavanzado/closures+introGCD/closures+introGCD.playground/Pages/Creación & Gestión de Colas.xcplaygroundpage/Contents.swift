//: [Previous](@previous)

import Foundation

/*: # Creación de Colas
 
 La forma más sencilla es usar el init designado de `DispatchQueue`
 */


let queue = DispatchQueue(label: "io.keepcoding.background.downloads")
// El label es opcional, pero es de buen gust darle un "nombre" a la cola. Esto sirve
// luego para cuando estás depurando, que puedas saber qué cola es. Se suele usar la convención
// de dns invertido porque hay un montón de colas en una app, muchas pueden ser de frameworks de terceros
// así como de Cocoa. De esta forma a quién pertenece la cola.

queue.async {
    print("Slice the bun horizontally")
}

queue.async {
    print("Spread mayonaise on the bread")
}

queue.async {
    print("Grill the patty")
}

queue.async {
    print("Slice the tomatoes")
}

queue.async {
    print("Add the tomato to the lower slice of the bun")
    print("Put the patty on top of the tomato")
    print("Put the remaining bun on top")
}

/*: >Por qué, al contrario de `Go`, esto sale en orden?  *¿Donde coño está la concurrencia?*
 
 
 ## Colas con prioridad
 Al crear una cola, podemos darle un prioridad distinta de la por defect. Mucho cuidado con dar
 máxima prioridad a todo. No conseguireis nada con eso.
 
 */

let lazy = DispatchQueue(label: "io.keepcoding.lowPriority", qos: .utility)
// let lazy = DispatchQueue(label: "io.keepcoding.lowPriority", qos: .utility, attributes: .cocurrent)

lazy.async {
    if let text = "May the Force be with you!".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
        let url = URL(string:"http://artii.herokuapp.com/make?text=\(text)"),
        let ascii = try? String(contentsOf: url) { // try? --> puede dar excepción pero no quiero capturarla, si la hay devuelve un opcional
            print(ascii)
    }else{
        print("Something went wrong!")
    }
}

// Por qué no funciona?
// sleep(3)
// Por qué en una app normal eso no es un problema? El Runtime Loop

//: ## Para lo siguiente, pasémonos a un proyecto de Xcode


//: [Next](@next)
