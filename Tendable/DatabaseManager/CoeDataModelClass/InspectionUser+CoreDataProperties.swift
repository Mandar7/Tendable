//
//  InspectionUser+CoreDataProperties.swift
//  Tendable
//
//  Created by Choudhary, Mandar on 25/06/24.
//
//

import Foundation
import CoreData


extension InspectionUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InspectionUser> {
        return NSFetchRequest<InspectionUser>(entityName: "InspectionUser")
    }

    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var inspections: NSSet?

}

// MARK: Generated accessors for inspections
extension InspectionUser {

    @objc(addInspectionsObject:)
    @NSManaged public func addToInspections(_ value: InpectionCoreModel)

    @objc(removeInspectionsObject:)
    @NSManaged public func removeFromInspections(_ value: InpectionCoreModel)

    @objc(addInspections:)
    @NSManaged public func addToInspections(_ values: NSSet)

    @objc(removeInspections:)
    @NSManaged public func removeFromInspections(_ values: NSSet)

}

extension InspectionUser : Identifiable {

}
