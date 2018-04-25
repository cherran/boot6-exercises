import Foundation

var str = "Hello, playground"

// En Swift no hay recolector de basura, hay ARC.
// Hay tres tipos de relaciones entre objetos:

/*:
 * * strong --> matrimonio, hasta que la muerte los separe (uno de los dos objetos).
 *
 * * weak --> cuando uno muere ¡, la referencia que tiene el otro a él se convierte en nil -> siempre deben ser var opcionales!
 *
 * * onowned: --> desaparece, pero la referencia no se convierte en un nil, por lo que si se usa la aplicación peta --> Se utiliza sólo cuando se está bastante seguro de que los dos objetos  van a morir opcional, así te libras de tener que trabajar con un opcional. Casi siempre es mejor usar weak.
 *
 */

typealias Name = String

final class Pilot {
    let name: Name
    var ship: SpaceShip?
    
    init(name: Name, ship: SpaceShip?) {
        (self.name, self.ship) = (name, ship)
    }
    
}


typealias SpaceShipType = String

final class SpaceShip {
    let name: Name
    let type: SpaceShipType
    // var pilot: Pilot?
    weak var pilot: Pilot?
    
    init(name: Name, type: SpaceShipType, pilot: Pilot?) {
        (self.name, self.type, self.pilot) = (name, type, pilot)
    }
}

let str2 = "Funciona hasta aquí :)"


let hanSolo = Pilot(name: "Han Solo", ship: nil)

let milleniumFalcon = SpaceShip(name: "Millenium Falcon",
                                type: "Corellian Light Freighter",
                                pilot: hanSolo)
// Hasta aquí la relación entre nave y piloto está bien, pero y la relación entre pilot y nave???
hanSolo.ship = milleniumFalcon

// ¿Está bien? Fuciona pero no!!!!!!
// Agujero de memoria, isla de basura. Ninguno de los dos deja de apuntar al otro, por lo que ninguno de los objetos se borrará nunca por el ARC!!!! Ya que siempre existirá una referencia a cada uno de los objetos
// --> Solución: hacer que al menos una de las relaciones entre los dos objetos sea weak
// Quien vaya a morir antes debería ser el weak



















