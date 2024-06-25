//
//  InspectionTypeModel+CoreDataProperties.swift
//  Tendable
//
//  Created by Choudhary, Mandar on 25/06/24.
//
//

import Foundation
import CoreData


extension InspectionTypeModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InspectionTypeModel> {
        return NSFetchRequest<InspectionTypeModel>(entityName: "InspectionTypeModel")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var access: String?
    @NSManaged public var parentInspection: InpectionCoreModel?

}

extension InspectionTypeModel : Identifiable {

}
