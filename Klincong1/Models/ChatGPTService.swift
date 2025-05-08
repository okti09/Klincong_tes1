//
//  ChatGPTService.swift
//  Klincong1
//
//  Created by Shafa Tiara Tsabita Himawan on 07/05/25.
//

import Foundation

// MARK: - Config
enum Config {
    private static let apiKey: String = {
        guard let filePath = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: filePath) as? [String: AnyObject],
              let apiKey = dict["OpenAIAPIKey"] as? String else {
            fatalError("Couldn't find 'Config.plist' or 'OpenAIAPIKey' in it.")
        }
        return apiKey
    }()
    
    static var openAIAPIKey: String {
        return apiKey
    }
}

// MARK: - Models
struct ChatGPTResponse: Codable {
    let id: String
    let object: String
    let created: Int
    let model: String
    let choices: [Choice]
    let usage: Usage
    
    struct Choice: Codable {
        let index: Int
        let message: Message
        let finishReason: String?
        
        enum CodingKeys: String, CodingKey {
            case index
            case message
            case finishReason = "finish_reason"
        }
    }
    
    struct Message: Codable {
        let role: String
        let content: String
    }
    
    struct Usage: Codable {
        let promptTokens: Int
        let completionTokens: Int
        let totalTokens: Int
        
        enum CodingKeys: String, CodingKey {
            case promptTokens = "prompt_tokens"
            case completionTokens = "completion_tokens"
            case totalTokens = "total_tokens"
        }
    }
}

struct ChatGPTRequest: Codable {
    let model: String
    let messages: [Message]
    
    struct Message: Codable {
        let role: String
        let content: String
    }
}

struct CleaningTask: Codable {
    let group: Int
    let tasks: [String] 
}

// MARK: - Service
class ChatGPTService {
    private let apiKey: String
    private let baseURL = "https://api.openai.com/v1/chat/completions"
    
    init() {
        self.apiKey = Config.openAIAPIKey
        print("API Key:", Config.openAIAPIKey)
    }
    
    func analyzeImage(imageBase64: String) async throws -> String {
        let prompt = """
        Analyze this image and provide a detailed list of cleaning tasks that need to be done. 
        Break down the tasks into small, manageable groups of 3 tasks each. 
        For each task, provide specific details about what needs to be cleaned and how.
        Format the response as a JSON array of task groups, where each group contains exactly 3 tasks.
        """
        
        let requestBody: [String: Any] = [
            "model": "gpt-4.1",
            "messages": [
                [
                    "role": "user",
                    "content": [
                        ["type": "text", "text": prompt],
                        [
                            "type": "image_url",
                            "image_url": [
                                "url": "data:image/jpeg;base64,\(imageBase64)"
                            ]
                        ]
                    ]
                ]
            ],
            "max_tokens": 1000
        ]
        
        guard let url = URL(string: baseURL) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        
        print("Mulai request ke OpenAI")
        let (data, response) = try await URLSession.shared.data(for: request)
        print("Selesai request ke OpenAI")
        
        if let httpResponse = response as? HTTPURLResponse,
           !(200...299).contains(httpResponse.statusCode) {
            let body = String(data: data, encoding: .utf8) ?? ""
            print("HTTP Error:", httpResponse.statusCode, body)
            throw URLError(.badServerResponse)
        }
        
        let chatGPTResponse = try JSONDecoder().decode(ChatGPTResponse.self, from: data)
        print("Response JSON:", String(data: data, encoding: .utf8) ?? "")
        return chatGPTResponse.choices.first?.message.content ?? ""
    }
    
    func analyzeImageAndGenerateTasks(imageDescription: String, availableTools: [String]) async throws -> [CleaningTask] {
        let toolsList = availableTools.joined(separator: ", ")
        let prompt = """
        Create an ultra-detailed cleaning task list for this studio apartment image.
        Rules:
        - Create as many groups as needed (minimum 1 group)
        - Each group must have exactly 3 tasks
        - Each task must be ONE single action only
        - NEVER combine actions in one task
        - Break EVERY complex action into its smallest possible steps
        - Start each task with a single action verb
        - Prioritize urgent tasks
        - Focus on one area per group
        - Group similar tasks together
        - ONLY use available cleaning tools: \(toolsList)
        - If a task requires a tool that's not available, skip that task
        
        Image: \(imageDescription)
        
        Return JSON format:
        [
            {"group": 1, "tasks": ["task1", "task2", "task3"]},
            ... (add more groups as needed)
        ]
        """
        
        let request = ChatGPTRequest(
            model: "gpt-4.1",
            messages: [
                .init(role: "system", content: "You are a cleaning task analyzer. Break EVERY task into its smallest possible single action. Never combine actions. Only use available tools."),
                .init(role: "user", content: prompt)
            ]
        )
        
        var urlRequest = URLRequest(url: URL(string: baseURL)!)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try JSONEncoder().encode(request)
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        let response = try JSONDecoder().decode(ChatGPTResponse.self, from: data)
        
        if let jsonData = response.choices.first?.message.content.data(using: .utf8) {
            return try JSONDecoder().decode([CleaningTask].self, from: jsonData)
        }
        
        throw NSError(domain: "ChatGPTService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to parse response"])
    }
}

