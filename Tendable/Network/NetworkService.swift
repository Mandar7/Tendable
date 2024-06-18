//
//  UserService.swift
//  Tendable
//
//  Created by Choudhary, Mandar on 15/06/24.
//

// Services/UserService.swift
import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    func registerUser(credential: [String: Any], completion: @escaping (Bool, String) -> Void) {
        APIClient.shared.request(.registerUser, body: credential, completion: completion)
    }
    
    func loginUser(credential: [String: Any], completion: @escaping (Bool, String) -> Void) {
        APIClient.shared.request(.loginUser, body: credential, completion: completion)
    }
    
    func getNewInspection(completion: @escaping (Result<InspectionModel, Error>) -> Void) {
        APIClient.shared.request(.getNewInspection, completion: completion)
    }
    
    func submitInspection(answerInspection: [String: Any], completion: @escaping (Bool, String) -> Void) {
        APIClient.shared.request(.submitInspection, body: answerInspection, completion: completion)
    }
}
