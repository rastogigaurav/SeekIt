//
//  APIHelper.swift
//  SeekIt
//
//  Created by g.b.rastogi on 29/09/24.
//

import Foundation

// Helper to load the JSON file from the app bundle
func stubbedResponse(_ filename: String) -> Data {
    guard let path = Bundle.main.path(forResource: filename, ofType: "json") else {
        print("Warning: Could not find \(filename).json in the bundle.")
        return Data()
    }
    
    do {
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        return data
    } catch {
        print("Error loading \(filename).json: \(error)")
        return Data()
    }
}

