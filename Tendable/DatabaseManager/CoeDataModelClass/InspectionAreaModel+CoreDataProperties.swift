//
//  InspectionAreaModel+CoreDataProperties.swift
//  Tendable
//
//  Created by Choudhary, Mandar on 25/06/24.
//
//

import Foundation
import CoreData


extension InspectionAreaModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InspectionAreaModel> {
        return NSFetchRequest<InspectionAreaModel>(entityName: "InspectionAreaModel")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var parentInspection: InpectionCoreModel?

}

extension InspectionAreaModel : Identifiable {

}
