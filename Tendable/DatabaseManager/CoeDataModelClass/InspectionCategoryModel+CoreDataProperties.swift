//
//  InspectionCategoryModel+CoreDataProperties.swift
//  Tendable
//
//  Created by Choudhary, Mandar on 25/06/24.
//
//

import Foundation
import CoreData


extension InspectionCategoryModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InspectionCategoryModel> {
        return NSFetchRequest<InspectionCategoryModel>(entityName: "InspectionCategoryModel")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var subQuestions: NSSet?
    @NSManaged public var parentSurvey: InspectionSurveyModel?

}

// MARK: Generated accessors for subQuestions
extension InspectionCategoryModel {

    @objc(addSubQuestionsObject:)
    @NSManaged public func addToSubQuestions(_ value: InspectionQuestionsModel)

    @objc(removeSubQuestionsObject:)
    @NSManaged public func removeFromSubQuestions(_ value: InspectionQuestionsModel)

    @objc(addSubQuestions:)
    @NSManaged public func addToSubQuestions(_ values: NSSet)

    @objc(removeSubQuestions:)
    @NSManaged public func removeFromSubQuestions(_ values: NSSet)

}

extension InspectionCategoryModel : Identifiable {

}
