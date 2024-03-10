//
//  NetworkLayer.swift
//  Bundle - TestProject
//
//  Created by Artun Erol on 9.03.2024.
//

import Foundation

enum CustomError: Error {
    case requestError(error: Error)
    case throwError
    case defaultError
}

class NetworkLayer {
    private let baseURL = "https://bundle-api-contentstore-production.bundlenews.co/contentstore"
    private let requestHeaders: [String : String] = [
        "Content-Type" : "application/json",
        "language" : "TR",
        "country" : "TR",
        "DeviceToken" : "9aa43dab-d2ca-4dc1-b374-afb462b3b8e5",
        "Platform" : "IOS",
    ]
    
    func request<T: Codable>(model: T.Type, 
                             apiURL: ApiURLs,
                             completion: @escaping (Result<T, CustomError>) -> Void) {
        let urlString = baseURL + apiURL.getURLString()
        
        var request = URLRequest(url: urlString.convertToURL())
        request.allHTTPHeaderFields = requestHeaders
        
        URLSession.shared.dataTask(with: request) {data, _, error in
            guard let data = data else { return }
            
            if let error = error {
                completion(.failure(.requestError(error: error)))
            }
            
            if let dataResponse = try? JSONDecoder().decode(model, from: data) {
                completion(.success(dataResponse))
            } else {
                completion(.failure(.throwError))
            }
        }.resume()
    }
}

enum ApiURLs {
    case packageList
    case packageSource(id: Int)
    
    func getURLString() -> String {
        switch self {
        case .packageList:
            return "/packages"
        case .packageSource(id: let id):
            return "/packages/\(String(id))"
        }
    }
}
