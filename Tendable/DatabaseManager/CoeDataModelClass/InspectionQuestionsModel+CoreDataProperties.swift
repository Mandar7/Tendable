//
//  InspectionQuestionsModel+CoreDataProperties.swift
//  Tendable
//
//  Created by Choudhary, Mandar on 25/06/24.
//
//

import Foundation
import CoreData


extension InspectionQuestionsModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InspectionQuestionsModel> {
        return NSFetchRequest<InspectionQuestionsModel>(entityName: "InspectionQuestionsModel")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var selectedAnswerChoiceId: Int32
    @NSManaged public var answerChoices: NSSet?
    @NSManaged public var parentCategory: InspectionCategoryModel?

}

// MARK: Generated accessors for answerChoices
extension InspectionQuestionsModel {

    @objc(addAnswerChoicesObject:)
    @NSManaged public func addToAnswerChoices(_ value: InspectionAnswerModel)

    @objc(removeAnswerChoicesObject:)
    @NSManaged public func removeFromAnswerChoices(_ value: InspectionAnswerModel)

    @objc(addAnswerChoices:)
    @NSManaged public func addToAnswerChoices(_ values: NSSet)

    @objc(removeAnswerChoices:)
    @NSManaged public func removeFromAnswerChoices(_ values: NSSet)

}

extension InspectionQuestionsModel : Identifiable {

}
