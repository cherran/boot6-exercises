import Foundation
import CoreData


@objc(Note)
open class Note: _Note {
    
}

extension Note {
    // Custom logic goes here.
    
    convenience init(text: String, inContext: NSManagedObjectContext) {
        self.init(context: inContext)
        self.text = text
        self.creationDate = Date()
    }
    
    convenience init(text: String, photo: PhotoContainer, inContext: NSManagedObjectContext) {
        self.init(context: inContext)
        self.text = text
        self.creationDate = Date()
        self.photo = photo
    }
}
