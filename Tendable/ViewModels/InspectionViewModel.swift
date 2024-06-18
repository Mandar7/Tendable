//
//  UserViewModel.swift
//  Tendable
//
//  Created by Choudhary, Mandar on 15/06/24.
//

import Foundation

class InspectionViewModel: NSObject {
    
    private let networkService = NetworkService.shared
    
    func fetchNewInspection(completion: @escaping (Result<InspectionModel, Error>) -> Void) {
        networkService.getNewInspection(completion: completion)
    }
    
    func submitInspection(answerInspection: InspectionModel, completion: @escaping (Bool, String) -> Void) {
        let dict = answerInspection.toDictionary() ?? [:]
        networkService.submitInspection(answerInspection: dict, completion: completion)
    }
}


