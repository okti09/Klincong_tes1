//  CameraFlowView.swift
//  Klincong1
//
//  Created by Asri Oktianawati on 06/05/25.
//

import Foundation
import SwiftUI

struct CameraContentView: View {
    var selectedTools: [String]
    var onAnalyzeFinished: ([TaskGroup]) -> Void = { _ in }
    @State private var isLoading = false
    @State var errorMessage: String? = nil
    @State private var shouldOpenCamera = true

    var body: some View {
        VStack(spacing: 20) {
            if shouldOpenCamera {
                CameraView { capturedImage in
                    shouldOpenCamera = false
                    analyzeAndNavigate(with: capturedImage)
                }
            } else if isLoading {
                ProgressView("Analyzing...")
                    .font(.title2)
                    .padding()
            } else if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
                Button(action: {
                    self.errorMessage = nil
                    shouldOpenCamera = true
                }) {
                    Text("Coba Lagi")
                }
                .padding()
            }
        }
        .padding()
    }

    // Fungsi untuk ekstrak JSON dari blok markdown
    func extractJSON(from content: String) -> String? {
        guard let start = content.range(of: "```json")?.upperBound,
              let end = content.range(of: "```", range: start..<content.endIndex)?.lowerBound else {
            return nil
        }
        let jsonString = content[start..<end].trimmingCharacters(in: .whitespacesAndNewlines)
        return String(jsonString)
    }

    func analyzeAndNavigate(with image: UIImage) {
        print("analyzeAndNavigate dipanggil")
        isLoading = true
        errorMessage = nil
        Task {
            let imageBase64 = image.jpegData(compressionQuality: 0.7)?.base64EncodedString() ?? ""
            let service = ChatGPTService()
            do {
                let response = try await service.analyzeImage(imageBase64: imageBase64, toolsList: selectedTools)
                print("Response dari OpenAI:", response)
                let jsonString = extractJSON(from: response) ?? response
                print("JSON yang akan di-parse:", jsonString)
                if let data = jsonString.data(using: .utf8),
                   let array = try? JSONSerialization.jsonObject(with: data) as? [[String: [String: String]]] {
                    let taskGroups: [TaskGroup] = array.map { dict in
                        let tasks: [TaskItem] = dict.values.map { taskDict in
                            TaskItem(description: taskDict["description"] ?? "")
                        }
                        return TaskGroup(tasks: tasks)
                    }
                    print("onAnalyzeFinished akan dipanggil")
                    onAnalyzeFinished(taskGroups)
                    print("onAnalyzeFinished sudah dipanggil")
                } else {
                    errorMessage = "Failed to parse tasks.\nResponse: \(response)"
                }
            } catch {
                if let error = error as? URLError {
                    print("URLError:", error)
                }
                print("Error analyze:", error.localizedDescription)
                errorMessage = error.localizedDescription
            }
            isLoading = false
        }
    }
}

enum CameraFlowRoute: Hashable {
    case camera
    case task([TaskGroup])
}

#Preview {
    CameraContentView(selectedTools: [])
}
