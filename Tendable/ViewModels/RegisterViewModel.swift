//
//  RegisterViewModel.swift
//  Tendable
//
//  Created by Choudhary, Mandar on 15/06/24.
//

import Foundation

class RegisterViewModel: NSObject {
    
    private let userService = NetworkService.shared
    
    func registerUser(emaiId: String, password: String, completion: @escaping (Bool, String) -> Void) {
        let body = ["email": emaiId, "password": password]
        userService.registerUser(credential: body, completion: completion)
    }
    
    func loginUser(emaiId: String, password: String, completion: @escaping (Bool, String) -> Void) {
        let body = ["email": emaiId, "password": password]
        userService.loginUser(credential: body, completion: completion)
    }
}

