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
    var id: Int?
    var inspectionType: InspectionType?
    var area: InspectionArea?
    var survey: InspectionSurvey?
}

struct InspectionType: Codable {
    var id: Int?
    var name: String?
    var access: String?
}

struct InspectionArea: Codable {
    var id: Int?
    var name: String?
}

struct InspectionSurvey: Codable {
    var id: Int?
    var categories: [InspectionCategory]?
}

struct InspectionCategory: Codable {
    var id: Int?
    var name: String?
    var questions: [InspectionQuestions]?
}

struct InspectionQuestions: Codable {
    var id: Int?
    var name: String?
    var answerChoices: [InspectionAnswer]?
    var selectedAnswerChoiceId: Int?
}

struct InspectionAnswer: Codable {
    var id: Int?
    var name: String?
    var score: Double?
}


extension Encodable {
    func toDictionary() -> [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
