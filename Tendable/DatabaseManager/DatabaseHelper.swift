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
    
    private override init() {
        super.init()
    }
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    func saveInspection(userMailId: String, inspection: Inspection) {
        var newInspection = NSEntityDescription.insertNewObject(forEntityName: "InpectionCoreModel",
                    into: context) as! InpectionCoreModel
        
        newInspection.id = Int32(inspection.id ?? 0)
        
        let inspectionAreaModel = InspectionAreaModel(context: context)
        inspectionAreaModel.id = Int32(inspection.area?.id ?? 0)
        inspectionAreaModel.name = inspection.area?.name
        
        let inspectionTypeModel = InspectionTypeModel(context: context)
        inspectionTypeModel.id = Int32(inspection.inspectionType?.id ?? 0)
        inspectionTypeModel.name = inspection.inspectionType?.name
        inspectionTypeModel.access = inspection.inspectionType?.access
        
        let inspectionSurveyModel = InspectionSurveyModel(context: context)
        inspectionSurveyModel.id = Int32(inspection.survey?.id ?? 0)

        newInspection.inspectionArea = inspectionAreaModel
        newInspection.inspectionType = inspectionTypeModel
        newInspection.inspectionSurvey = inspectionSurveyModel
        do {
            try context.save()
            print("Inspection saved successfully.")
        } catch {
            print("Failed to save inspection: \(error.localizedDescription)")
        }
    }
    
}
