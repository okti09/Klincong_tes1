//
//  APIConfig.swift
//  Klincong1
//
//  Created by Shafa Tiara Tsabita Himawan on 07/05/25.
//

import Foundation

enum APIConfig {
    private static let configFileName = "Config"
    private static let configFileType = "plist"
    
    static var openAIKey: String {
        if let envKey = ProcessInfo.processInfo.environment["OPENAI_API_KEY"] {
            return envKey
        }
        
        guard let configPath = Bundle.main.path(forResource: configFileName, ofType: configFileType),
              let configDict = NSDictionary(contentsOfFile: configPath) as? [String: Any],
              let apiKey = configDict["OpenAIAPIKey"] as? String else {
            fatalError("OpenAI API Key not found. Please add it to Config.plist or set OPENAI_API_KEY environment variable")
        }
        
        return apiKey
    }
    
    static func validateAPIKey() -> Bool {
        return !openAIKey.isEmpty
    }
}
