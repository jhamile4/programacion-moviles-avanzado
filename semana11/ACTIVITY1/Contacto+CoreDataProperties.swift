//
//  Contacto+CoreDataProperties.swift
//  ACTIVITY1
//
//  Created by Tecsup on 25/05/26.
//
//

public import Foundation
public import CoreData


public typealias ContactoCoreDataPropertiesSet = NSSet

extension Contacto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contacto> {
        return NSFetchRequest<Contacto>(entityName: "Contacto")
    }

    @NSManaged public var nombre: String?
    @NSManaged public var direccion: String?
    @NSManaged public var telefono: String?

}

extension Contacto : Identifiable {

}
