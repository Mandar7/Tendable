//
//  NetworkUtility.swift
//  Tendable
//
//  Created by Choudhary, Mandar on 15/06/24.
//

import Foundation

enum APIEndpoint {
    case registerUser
    case loginUser
    case getNewInspection
    case submitInspection
    
    var urlString: String {
        switch self {
        case .registerUser:
            return "http://localhost:5001/api/register"
        case .loginUser:
            return "http://localhost:5001/api/login"
        case .getNewInspection:
            return "http://localhost:5001/api/inspections/start"
        case .submitInspection:
            return "http://localhost:5001/api/inspections/submit"
        }
    }
    
    var url: URL {
        return URL(string: self.urlString)!
    }
    
    var httpMethod: String {
        switch self {
        case .getNewInspection:
            return "GET"
        case .registerUser, .loginUser, .submitInspection:
            return "POST"
        }
    }
}

