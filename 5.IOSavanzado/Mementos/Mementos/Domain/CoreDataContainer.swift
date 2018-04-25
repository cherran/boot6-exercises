//
//  Container.swift
//  Mementos
//
//  Created by hijos on 22/4/18.
//  Copyright © 2018 Carlos de la Herrán. All rights reserved.
//

import UIKit
import CoreData



struct CoreDataContainer {
    // Singleton
    static var `default`: KCPersistentContainer = {
        let container = KCPersistentContainer(name: "Mementos") // Podríamos tener más de uno, aunque no es habitual
        // El nombre tiene que ser el de Mementos.xcdatamodeld
        container.loadPersistentStores(completionHandler: { (description, error) in
            if let err = error {
                // Loggear esto en crashlytics, porque la cagaste pero bien
                fatalError("Se jodió el invento")
            }
        })
        return container
    } ()
}


//
open class KCPersistentContainer : NSPersistentContainer{
    
    
    open
    func zapAllData(){
        
        // Al quitar el store, se eliminan los ficheros:
        let container = CoreDataContainer.default
        let coord = container.persistentStoreCoordinator
        
        let url = type(of:self).defaultDirectoryURL()
        let model = url.appendingPathComponent("Mementos.sqlite")
        
        // Eliminamos el store
        do{
            try coord.destroyPersistentStore(at: model, ofType: NSSQLiteStoreType, options: nil)
        }catch{
            fatalError("Error while deleting persistent coord")
        }
        
        // Añadimos uno nuevo
        do{
            let _ = try coord.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: model, options: nil)
        }catch{
            fatalError("Error while trying to add store")
        }
        
        
        
    }
}



func addDummyData() {
    
    // Elimino todos los datos anteriores
    CoreDataContainer.default.zapAllData()
    
    for idx in 1...5 {
        let note = Note(text: "Nota nº \(idx)", inContext: CoreDataContainer.default.viewContext)
        let _ = PhotoContainer(image: UIImage(named: "imagen.png")!, note: note, inContext: CoreDataContainer.default.viewContext)
    }
}






func trastearConCoreData() {
    
    let context = CoreDataContainer.default.viewContext
    
    let note1 = Note(text: "Mi primera nota", inContext: context)
    print(note1)
    print()
    print()
    
    let photo1 = PhotoContainer(image: UIImage(named: "imagen.png")!,
                                note: note1, inContext: context)
    
    // A ver si la nota se ha enterado
    print(note1)
    print(photo1)
    print()
    print()
    
    // Muchas notas
    for index in 1...200 {
        _ = Note(text: "Nota \(index)", inContext: context)
        // Aunque no las guardemos en una variable, las notas estarán todas referenciadas en el contexto
    }
    
    
    // Buscar objetos
    let request = Note.fetchRequest() // NSFetchRequest<Note>()
    request.fetchBatchSize = 100
    // Orden de los resultados
    request.sortDescriptors = [NSSortDescriptor(key: NoteAttributes.text.rawValue, ascending: false),
                                NSSortDescriptor(key: NoteAttributes.creationDate.rawValue, ascending: true)]
    
    // Hacer la búsqueda
    guard let results = try? context.fetch(request) as! [Note] else {
        print("Error en la búsqueda!!!!!!")
        return
    }
    
    dump(results.count)
    dump(results[4])
    print()
    print()
    
    // Guardar objetos
    if context.hasChanges {
        do {
            try context.save()
        } catch {
            print("qué mal rollo")
        }
    }
    
    
    // Creamos más notas
    var extraNotes = [Note]()
    for _ in 1...1000 {
        extraNotes.append(Note(text: "Toma nota!!!", inContext: context))
    }

    
    // Hacer la búsqueda otra vez para ver si están todas
    guard let newResults = try? context.fetch(request) as! [Note] else { return }
    dump(newResults.count)
    print()
    print()
    
    
    // Vamos a borrar todas las nuevas
    for note in extraNotes {
        context.delete(note)
    }
    extraNotes = [] // No quiero referencias a los no-muertos
    
    
    // Hacer la búsqueda otra vez para ver si desaparecieron los no-muertos
    guard let anyDead = try? context.fetch(request) as! [Note] else { return }
    dump(anyDead.count)
    print()
    print()
    
    
}





//func initCoreData() {
//
//    // Abrir la bbdd
//    let container = Container.default
//    container.loadPersistentStores() { (description, error) in
//        if let err = error {
//            fatalError("Failed to load persistent store: \(err)")
//        }
//    }
//
//}

//
//func playWithCoreData() {
//
//    // --------------------------------- Crear objetos ---------------------------------
//
//    let n1 = NSEntityDescription.insertNewObject(forEntityName: Note.entityName,
//                                                 into: Container.default.viewContext) as! Note // Sin inicializador
//    n1.text = "Esto es una prueba"
//    n1.creationDate = NSDate()
//
//    print(n1)
//
//    let n2 = NSEntityDescription.insertNewObject(forEntityName: Note.entityName,
//                                                 into: Container.default.viewContext) as! Note // Sin inicializador
//    n2.text = "Otra nota"
//    n2.creationDate = NSDate()
//
//
//
//    let photo = NSEntityDescription.insertNewObject(forEntityName: PhotoContainer.entityName,
//                                                    into: Container.default.viewContext) as! PhotoContainer
//    let img = UIImage(named: "imagen.png")
//    photo.imageData = NSData(data: UIImagePNGRepresentation(img!)!)
//
//
//
//    // --------------------------------- Relacionarlos ---------------------------------
//    n1.photo = photo
//
//
//
//    // --------------------------------- Modificar ---------------------------------
//
//    n2.text = "nueva nota"
//        // Todo lo que hemos hecho hasta ahora está solo en memoria todavía, si muere la aplicación desaparecen
//
//
//
//    // --------------------------------- Buscar ---------------------------------
//
//    let request = NSFetchRequest<Note>(entityName: Note.entityName)
//    request.fetchBatchSize = 100 // Como mucho ir buscándolos de 100 en 100
//    request.sortDescriptors = [NSSortDescriptor(key: "text", ascending: true)] // Criterios de ordenación
//
//    let results = try? Container.default.viewContext.execute(request)
//    print(results)
//
//
//
//    // --------------------------------- Borrar ---------------------------------
//
//    Container.default.viewContext.delete(n2)
//
//
//
//    // --------------------------------- Guardar ---------------------------------
//
//    try! Container.default.viewContext.save()
//}
