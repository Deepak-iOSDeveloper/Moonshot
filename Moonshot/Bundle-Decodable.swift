//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Deepak Kumar Behera on 07/06/25.
//
import SwiftUI

extension Bundle {
    
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError()
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError()
        }
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        guard let loadedData = try? decoder.decode(T.self, from: data) else {
            fatalError()
        }
        return loadedData
        
    }
}
