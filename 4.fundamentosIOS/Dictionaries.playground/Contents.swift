
import UIKit

class Point {
    let x: Double
    let y: Double
    
    init?(x: Double, y: Double) {
        guard x > 0 && y > 0 else { // Para salir lo más rápido de un sitio si los valores no son correctos
            return nil
        }
        self.x = x
        self.y = y
    }
}

let point = Point(x: 2, y: 3)
let invalidPoint = Point(x: -2, y: 10)


// Diccionario: Clave y valor
//let dict: [Point : String]

