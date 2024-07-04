//
//  InspectionAnswerModel+CoreDataProperties.swift
//  Tendable
//
//  Created by Choudhary, Mandar on 04/07/24.
//
//

import Foundation
import CoreData


extension InspectionAnswerModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InspectionAnswerModel> {
        return NSFetchRequest<InspectionAnswerModel>(entityName: "InspectionAnswerModel")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var score: Double
    @NSManaged public var inspectionQuestion: InspectionQuestionsModel?

}

extension InspectionAnswerModel : Identifiable {

}
