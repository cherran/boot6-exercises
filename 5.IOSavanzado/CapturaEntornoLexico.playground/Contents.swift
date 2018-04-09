import UIKit

var str = "Hello, playground"

var a = 7

var nsStr = NSString(string: "Hello from ObjC") // ARC(nsStr) = 1

var closure: (Int) -> (Int)

closure = { [b = a, unowned nsStr] (value: Int) in // [a] -> Lista de captura --> las convierte a variables locales
    // ARC(nsStr) = 2, ya que lo hemos metido en la lista de captura, se crea una nueva variable local que apunta a nsStr
    // modificadores para evitar el círculo de retención de ARC:
    //      weak: referencia débil, se representa el objeto como un optional
    //      unowned: lo usamos cuando estamos convencidos de que el objeto referenciado va a seguir existiendo después de la desaparición del closure
    //              Estamos seguros de que el objeto referenciado tienen una referencia strong sobre nosotros
    
    let result = b * value
    // Puede utilizar "a" ya que captura el entorno léxico
    
    print(nsStr)
    return result
}


a = 5

print(closure(2))

