//
//  User.swift
//  Tendable
//
//  Created by Choudhary, Mandar on 15/06/24.
//

import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let email: String
}

struct ErrorModel: Codable {
    let error: String?
}

struct UserCredential: Codable {
    let emailId: String?
    let password: String?
}

struct InspectionModel: Codable {
    var inspection: Inspection?
}

struct Inspection: Codable {
    let id: Int?
    let inspectionType: InspectionType?
    let area: InspectionArea?
    var survey: InspectionSurvey?
}

struct InspectionType: Codable {
    let id: Int?
    let name: String?
    let access: String?
}

struct InspectionArea: Codable {
    let id: Int?
    let name: String?
}

struct InspectionSurvey: Codable {
    let id: Int?
    var categories: [InspectionCategory]?
}

struct InspectionCategory: Codable {
    let id: Int?
    let name: String?
    var questions: [InspectionQuestions]?
}

struct InspectionQuestions: Codable {
    let id: Int?
    let name: String?
    let answerChoices: [InspectionAnswer]?
    var selectedAnswerChoiceId: Int?
}

struct InspectionAnswer: Codable {
    let id: Int?
    let name: String?
    let score: Double?
}


extension Encodable {
    func toDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
