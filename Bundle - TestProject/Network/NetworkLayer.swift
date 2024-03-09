//
//  NetworkLayer.swift
//  Bundle - TestProject
//
//  Created by Artun Erol on 9.03.2024.
//

import Foundation

enum CustomError: Error {
    case requestError
    case throwError
}

class NetworkLayer {
    private let requestHeaders: [String : String] = [
        "Content-Type" : "application/json",
        "language" : "TR",
        "country" : "TR",
        "DeviceToken" : "9aa43dab-d2ca-4dc1-b374-afb462b3b8e5",
        "Platform" : "IOS",
    ]
    
    func request<T: Codable>(with model: T, url: URL, completion: @escaping (Result<T, CustomError>) -> Void) {
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = requestHeaders
        
        URLSession.shared.dataTask(with: request) {data, _, error in
            guard let data = data else { return }
            
            if let error = error {
                completion(.failure(.requestError))
            }
            
            if let dataResponse = try? JSONDecoder().decode(T.self, from: data) {
                completion(.success(dataResponse))
            } else {
                completion(.failure(.throwError))
            }
        }.resume()
    }
}
