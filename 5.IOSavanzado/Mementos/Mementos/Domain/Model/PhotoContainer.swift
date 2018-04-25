import Foundation
import CoreData
import UIKit


@objc(PhotoContainer)
open class PhotoContainer: _PhotoContainer {
	
    convenience init(image: UIImage, note: Note, inContext: NSManagedObjectContext) {
        self.init(context: inContext)
        self.image = image
        self.note = note
    }
    
}

extension PhotoContainer {
    var image: UIImage {
        // Propiedad que no se guarda en la BBDD, prefiero hacerla en código para poder "toquetear"
        get {
            // NSData -> UIImage
            let img = UIImage(data: self.imageData as Data)
            return img!
        }
        
        set { // UIImage -> NSData
            let data = UIImagePNGRepresentation(newValue) // newValue es el nuevo parámetro recibido en el set
            self.imageData = data! as NSData
        }
    }
}
