//: [Previous](@previous)
import UIKit

class AnonymousBook {
    var title: String
    
    init(title: String) {
        self.title = title
    }
}


class Book: AnonymousBook {
    let authors: [String]
    
    // init Designado
    // recibe tantos parámetros como propiedades tiene el objeto
    init(title: String, authors: [String]) {
        // Primero, limpio mi desorden (posibles nils)
        // Doy valor a las nuevas propiedades que añado a mi clase
        self.authors = authors
        
        // Llamo a super.init para limpiar el desorden de la clase padre
        super.init(title: title)
    }
}

extension Book {
    // Init de convenienza -> llama al designado (self init)
    convenience init(title: String, author: String) {
        self.init(title: <#T##String#>, authors: [author])
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

let ab = AnonymousBook(title: "GoT")
let book = ab

ab.title = "GoT 2"

book.title // book y ab están apuntando al mismo objeto en memoria





//: [Next](@next)
