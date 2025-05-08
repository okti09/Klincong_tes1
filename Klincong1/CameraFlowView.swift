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
    @State private var shouldOpenCamera = false

    var body: some View {
        ZStack {
            if shouldOpenCamera {
                CameraView { capturedImage in
                    shouldOpenCamera = false
                    analyzeAndNavigate(with: capturedImage)
                }
                .ignoresSafeArea()
            } else {
                // CameraView sebagai background
                CameraView { _ in }
                    .ignoresSafeArea()
                GeometryReader { geo in
                    ZStack {
                        // Blur full screen
                        Color.clear.background(.ultraThinMaterial).ignoresSafeArea()
                        VStack {
                            Spacer()
                            VStack(spacing: 24) {
                                Text("Take photo of the spesific area to clean\n(Bed/Bathroom/Desk/Kitchen/Wardobe)")
                                    .font(.title3)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 24)
                                HStack(spacing: 28) {
                                    Image(systemName: "bed.double.fill").resizable().frame(width: 40, height: 32).foregroundColor(.white)
                                    Image(systemName: "shower.fill").resizable().frame(width: 32, height: 32).foregroundColor(.white)
                                    Image(systemName: "table.fill").resizable().frame(width: 40, height: 32).foregroundColor(.white)
                                    Image(systemName: "fork.knife").resizable().frame(width: 36, height: 32).foregroundColor(.white)
                                    Image(systemName: "sink.fill").resizable().frame(width: 36, height: 32).foregroundColor(.white)
                                    Image(systemName: "cabinet.fill").resizable().frame(width: 32, height: 32).foregroundColor(.white)
                                }
                            }
                            Spacer()
                            Button(action: { shouldOpenCamera = true }) {
                                Text("CAPTURE NOW")
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 18)
                                    .background(Color.white)
                                    .cornerRadius(32)
                                    .padding(.horizontal, 32)
                            }
                            .padding(.bottom, geo.safeAreaInsets.bottom + 32)
                        }
                    }
                }
            }
            if isLoading {
                ProgressView("Analyzing...")
                    .font(.title2)
                    .padding()
            } else if let errorMessage = errorMessage {
                VStack {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                    Button(action: {
                        self.errorMessage = nil
                        shouldOpenCamera = false
                    }) {
                        Text("Coba Lagi")
                    }
                    .padding()
                }
            }
        }
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
                   let array = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] {
                    let taskGroups: [TaskGroup] = array.compactMap { dict in
                        guard let tasks = dict["tasks"] as? [String] else { return nil }
                        let items = tasks.map { TaskItem(description: $0) }
                        return TaskGroup(tasks: items)
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
