// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Note.swift instead.

import Foundation
import CoreData

public enum NoteAttributes: String {
    case creationDate = "creationDate"
    case text = "text"
}

public enum NoteRelationships: String {
    case photo = "photo"
}

open class _Note: NSManagedObject {

    // MARK: - Class methods

    open class func entityName () -> String {
        return "Note"
    }

    open class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
        return NSEntityDescription.entity(forEntityName: self.entityName(), in: managedObjectContext)
    }

    // MARK: - Life cycle methods

    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }

    public convenience init?(managedObjectContext: NSManagedObjectContext) {
        guard let entity = _Note.entity(managedObjectContext: managedObjectContext) else { return nil }
        self.init(entity: entity, insertInto: managedObjectContext)
    }

    // MARK: - Properties

    @NSManaged open
    var creationDate: Date

    @NSManaged open
    var text: String?

    // MARK: - Relationships

    @NSManaged open
    var photo: PhotoContainer?

}

