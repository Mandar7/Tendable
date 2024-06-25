//
//  InspectionSurveyModel+CoreDataProperties.swift
//  Tendable
//
//  Created by Choudhary, Mandar on 25/06/24.
//
//

import Foundation
import CoreData


extension InspectionSurveyModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InspectionSurveyModel> {
        return NSFetchRequest<InspectionSurveyModel>(entityName: "InspectionSurveyModel")
    }

    @NSManaged public var id: Int32
    @NSManaged public var categories: NSSet?
    @NSManaged public var parentInspection: InpectionCoreModel?

}

// MARK: Generated accessors for categories
extension InspectionSurveyModel {

    @objc(addCategoriesObject:)
    @NSManaged public func addToCategories(_ value: InspectionCategoryModel)

    @objc(removeCategoriesObject:)
    @NSManaged public func removeFromCategories(_ value: InspectionCategoryModel)

    @objc(addCategories:)
    @NSManaged public func addToCategories(_ values: NSSet)

    @objc(removeCategories:)
    @NSManaged public func removeFromCategories(_ values: NSSet)

}

extension InspectionSurveyModel : Identifiable {

}
