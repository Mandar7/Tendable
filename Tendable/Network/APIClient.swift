//
//  APIClient.swift
//  Tendable
//
//  Created by Choudhary, Mandar on 15/06/24.
//

import Foundation

class APIClient {
    static let shared = APIClient()
    
    private init() {}
    
    func request<T: Decodable>(_ endpoint: APIEndpoint, completion: @escaping (Result<T, Error>) -> Void) {
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = endpoint.httpMethod
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : "No data received"])
                completion(.failure(error))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch let decodingError {
                completion(.failure(decodingError))
            }
        }
        
        task.resume()
    }
    
    func request(_ endpoint: APIEndpoint, body: [String: Any], completion: @escaping (Bool, String) -> Void) {
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = endpoint.httpMethod
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("API CALL: \(endpoint.url)")
        print("API Method: \(endpoint.httpMethod)")
        print("API HEADER: \(String(describing: request.allHTTPHeaderFields))")
        print("API Body: \(body)")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            print("Failed to serialize JSON")
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(false, error.localizedDescription)
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : "No data received"])
                completion(false, error.localizedDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            // Check the status code
            let statusCode = httpResponse.statusCode
            print("Status code: \(statusCode)")
            
            if (200...299).contains(statusCode) {
                completion(true, "")
            } else {
                do {
                    let errorMessage = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    completion(false, errorMessage?["error"] as? String ?? "")
                    print("Server error: \(String(describing: errorMessage))")
                } catch {
                    completion(false, "Server error message")
                }
            }
        }
        
        task.resume()
    }
}
