//
//  Userdefaults + Save.swift
//  Bundle - TestProject
//
//  Created by Artun Erol on 13.03.2024.
//

import Foundation

extension UserDefaults {
    func getData<T: Codable>(with key: String, for type: T.Type) -> T? {
        guard let userdefaultsData = UserDefaults.standard.data(forKey: key) else {
            print("No userdefaults data for key")
            return nil
        }
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(type, from: userdefaultsData)
            return decodedData
        } catch {
            print("Can not decode data for userdefaults")
        }
        
        return nil
    }
    
    func saveData(data: Codable, key: String) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(data)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("Can not encode user for userdefaults")
        }
    }
}
