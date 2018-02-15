//: [Previous](@previous)
import UIKit

class AnonymousBook {
    var title: String
    var genre: Genre
    
    init(title: String, genre: Genre) {
        self.title = title
        self.genre = genre
    }
}

extension AnonymousBook: CustomStringConvertible {
    var description: String {
        return "Título: \(title). Género: \(genre.rawValue)"
    }
}


class Book: AnonymousBook {
    let authors: [String]
    
    // init Designado
    // recibe tantos parámetros como propiedades tiene el objeto
    init(title: String, authors: [String], genre: Genre) {
        // Primero, limpio mi desorden (posibles nils)
        // Doy valor a las nuevas propiedades que añado a mi clase
        self.authors = authors
        
        // Llamo a super.init para limpiar el desorden de la clase padre
        super.init(title: title, genre: genre)
    }
}

extension Book {
    // Init de convenienza -> llama al designado (self init)
    convenience init(title: String, author: String, genre: Genre) {
        self.init(title: <#T##String#>, authors: [author], genre: genre)
    }
}


// por convención, se marca siempre las clases como finales
// Más tarde, si necesitamos heredar de ella quitamos el final
final class BookCharacter {
    let name: String
    let book: Book
    
    init(name: String, book: Book) {
        self.name = name
        self.book = book
    }
}


// Las clases también implementan protocolos
extension BookCharacter: CustomStringConvertible {
    var description: String {
        return "\(type(of: self)): \(name). Appears in \(book.title)"
    }
}


// Sobreescritura de métodos
final class MyView: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Hago lo mio aquí
    }
}


// Las clases son Reference-Types (a diferencia de las structs que son Tipos por Valor)

//let ab = AnonymousBook(title: "GoT")
//let book = ab
//
//ab.title = "GoT 2"
//
//book.title // book y ab están apuntando al mismo objeto en memoria


// ENUMS
enum Genre: String {
    case romance = "Romance"
    // "Romance" == genre.rawValue
    case sciFi = "Ciencia Ficción"
    
    // Las enums pueden tener propiedades
    var myProperty: Int {
        switch self {
        case .romance:
            return 14
        case .sciFi:
            return 98
        default:
            return 0
        }
    }
}


let ab = AnonymousBook(title: "GoT", genre: .romance) // .romance == Genre.romance
print(ab.description)



/*: Opcionales
 
 var nombre: Tipo?
 */

var alias: String? = "El bicho" // Envuelvo al tipo string en un tipo opcional (Optional<String>)
type(of: alias)
// alias = nil // Ahora si que lo puedo hacer


// Acceso al valor de un opcional ---------

// 1: Por cojones
print(alias!) // Si es nil crashea la aplicación

// 2: Desempaquetado seguro

// 2.1 if let
if let alias = alias { // Sólo entra si alias != nil
    print(alias)
    // El "alias" (variable) desempaquetado solo existe dentro de este scope
}
print(alias)

// 2.2 guard
func printAlias(_ alias: String?) {
    guard let alias = alias else {
        return
    }
    
    print(alias)
}

printAlias(alias)








//: [Next](@next)
