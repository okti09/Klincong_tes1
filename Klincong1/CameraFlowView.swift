//  CameraFlowView.swift
//  Klincong1
//
//  Created by Asri Oktianawati on 06/05/25.
//

import Foundation
import SwiftUI

struct CameraContentView: View {
    @State private var image: UIImage?
    @State private var path: [Route] = []
    @State private var showInstructions = false
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 20) {
                if let image = image {
                    // preview foto
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                        .cornerRadius(12)
                    
                    HStack(spacing: 20) {
                        Button(action: {
                            path.append(.camera) // RETAKE
                        }) {
                            Label("Retake", systemImage: "camera.rotate")
                                .padding()
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        
                        Button(action: {
                            startAnalyze(image: image) // ANALYZE
                        }) {
                            Label("Start Analyze", systemImage: "magnifyingglass")
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
                else {
                    Button("Buka Kamera") {
                        path.append(.camera)
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .camera:
                    CameraView { capturedImage in
                        self.image = capturedImage
                        path.removeLast()
                    }
                }
            }
            .padding()
        }
    }
    
    // FUNGSI ANALISIS FOTO
    func startAnalyze(image: UIImage) {
        print("📸 Memulai analisis gambar...")
        // proses analisis di sini
    }
}

#Preview {
    CameraContentView()
}

