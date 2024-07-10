//
//  DatabaseHelper.swift
//  Tendable
//
//  Created by Choudhary, Mandar on 25/06/24.
//

import UIKit
import CoreData

class DatabaseHelper: NSObject {
    
    static let sharedInstance = DatabaseHelper()
    var LOGGED_IN_USER_ID = ""
    var LOGGED_IN_USER_PASSWORD = ""
    
    private override init() {
        super.init()
    }
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func saveUser(userMailId: String, userPassword: String) {
        let newUser = InspectionUser(context: context)
        newUser.email = userMailId
        newUser.password = userPassword
        
        do {
            try context.save()
            print("User saved successfully.")
        } catch {
            print("Failed to save user: \(error.localizedDescription)")
        }
    }
    
    func getUserWith(userMailId: String) -> InspectionUser? {
        let fetchRequest = NSFetchRequest<InspectionUser>(entityName: "InspectionUser")
        // Create and set the predicate
        let predicate = NSPredicate(format: "email == %@", userMailId)
        fetchRequest.predicate = predicate

        do {
            let result = try context.fetch(fetchRequest)
            return result.first
        } catch {
            print("Failed fetching: \(error)")
        }
        return nil
    }
    
    func getInspectionsWith(userMailId: String) -> [InpectionCoreModel]? {
        let fetchRequest = NSFetchRequest<InpectionCoreModel>(entityName: "InpectionCoreModel")
        // Create and set the predicate
        let predicate = NSPredicate(format: "parentUserId == %@", userMailId)
        fetchRequest.predicate = predicate

        do {
            let result = try context.fetch(fetchRequest)
            return result
        } catch {
            print("Failed fetching: \(error)")
        }
        return nil
    }

    func saveInspection(userMailId: String, inspection: Inspection, score: Double) {
        let newInspection = InpectionCoreModel(context: context)
        newInspection.id = Int32(inspection.id ?? 0)
        newInspection.score = Int32(score)
        
        let inspectionAreaModel = InspectionAreaModel(context: context)
        inspectionAreaModel.id = Int32(inspection.area?.id ?? 0)
        inspectionAreaModel.name = inspection.area?.name
        
        let inspectionTypeModel = InspectionTypeModel(context: context)
        inspectionTypeModel.id = Int32(inspection.inspectionType?.id ?? 0)
        inspectionTypeModel.name = inspection.inspectionType?.name
        inspectionTypeModel.access = inspection.inspectionType?.access
        
        let inspectionSurveyModel = InspectionSurveyModel(context: context)
        inspectionSurveyModel.id = Int32(inspection.survey?.id ?? 0)
        
        if let categories = inspection.survey?.categories {
            for category in categories {
                let categoryModel = InspectionCategoryModel(context: context)
                categoryModel.id = Int32(category.id ?? 0)
                categoryModel.name = category.name
                if let questions = category.questions {
                    for question in questions {
                        let questionModel = InspectionQuestionsModel(context: context)
                        questionModel.id = Int32(question.id ?? 0)
                        questionModel.name = question.name
                        questionModel.selectedAnswerChoiceId = Int32(question.selectedAnswerChoiceId ?? 0)
                        if let choices = question.answerChoices {
                            for choice in choices {
                                let answerChoiceModel = InspectionAnswerModel(context: context)
                                answerChoiceModel.id = Int32(choice.id ?? 0)
                                answerChoiceModel.name = choice.name
                                answerChoiceModel.score = choice.score ?? 0.0
                            }
                        }
                    }
                }
            }
        }
                
        newInspection.inspectionArea = inspectionAreaModel
        newInspection.inspectionType = inspectionTypeModel
        newInspection.inspectionSurvey = inspectionSurveyModel
        
        inspectionAreaModel.parentInspection = newInspection
        inspectionTypeModel.parentInspection = newInspection
        inspectionSurveyModel.parentInspection = newInspection
        
        if let user = getUserWith(userMailId: userMailId) {
            user.addToInspections(newInspection)
            newInspection.parentUser = user
            newInspection.parentUserId = userMailId
        }
        
        do {
            try context.save()
            print("Inspection saved successfully.")
        } catch {
            print("Failed to save inspection: \(error.localizedDescription)")
        }
    }
    
    func getInspectionFromInspectionModel(model: InpectionCoreModel) -> Inspection {
        
        var newInspection = Inspection(id: nil, inspectionType: nil, area: nil)
        newInspection.id = Int(model.id)
        
        var inspectionAreaModel = InspectionArea(id: nil, name: nil)
        inspectionAreaModel.id = Int(model.inspectionArea?.id ?? 0)
        inspectionAreaModel.name = model.inspectionArea?.name
        
        var inspectionTypeModel = InspectionType(id: nil, name: nil, access: nil)
        inspectionTypeModel.id = Int(model.inspectionType?.id ?? 0)
        inspectionTypeModel.name = model.inspectionType?.name
        inspectionTypeModel.access = model.inspectionType?.access
        
        var inspectionSurveyModel = InspectionSurvey(id: nil, categories: nil)
        inspectionSurveyModel.id = Int(model.inspectionSurvey?.id ?? 0)
        
        if let categories: [InspectionCategoryModel] = model.inspectionSurvey?.categories?.allObjects as? [InspectionCategoryModel] {
            for category in categories {
                var categoryModel = InspectionCategory(id: nil, name: nil, questions: nil)
                categoryModel.id = Int(category.id)
                categoryModel.name = category.name
                if let questions: [InspectionQuestionsModel] =  category.subQuestions?.allObjects as? [InspectionQuestionsModel] {
                    for question in questions {
                        let questionModel = InspectionQuestionsModel(context: context)
                        questionModel.id = Int32(question.id)
                        questionModel.name = question.name
                        questionModel.selectedAnswerChoiceId = Int32(question.selectedAnswerChoiceId)
                        if let choices: [InspectionAnswerModel] = question.answerChoices?.allObjects as? [InspectionAnswerModel] {
                            for choice in choices {
                                let answerChoiceModel = InspectionAnswerModel(context: context)
                                answerChoiceModel.id = Int32(choice.id)
                                answerChoiceModel.name = choice.name
                                answerChoiceModel.score = choice.score
                            }
                        }
                    }
                }
            }
        }
                
        newInspection.area = inspectionAreaModel
        newInspection.inspectionType = inspectionTypeModel
        newInspection.survey = inspectionSurveyModel
        return newInspection
    }
}
