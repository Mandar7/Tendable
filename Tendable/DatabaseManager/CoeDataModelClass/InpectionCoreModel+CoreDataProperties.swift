//
//  InpectionCoreModel+CoreDataProperties.swift
//  Tendable
//
//  Created by Choudhary, Mandar on 25/06/24.
//
//

import Foundation
import CoreData


extension InpectionCoreModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InpectionCoreModel> {
        return NSFetchRequest<InpectionCoreModel>(entityName: "InpectionCoreModel")
    }

    @NSManaged public var id: Int32
    @NSManaged public var inspectionType: InspectionTypeModel?
    @NSManaged public var inspectionArea: InspectionAreaModel?
    @NSManaged public var inspectionSurvey: InspectionSurveyModel?
    @NSManaged public var parentUser: InspectionUser?

}

extension InpectionCoreModel : Identifiable {

}
