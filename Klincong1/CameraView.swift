//
//  CameraView.swift
//  Klincong1
//
//  Created by Asri Oktianawati on 06/05/25.
//
import Foundation
import SwiftUI

struct CameraFlowView: View {
    @State private var showCamera = false
    @State private var capturedImage: UIImage? = nil

    var body: some View {
        VStack {
            if let image = capturedImage {
                // Show the image preview
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 400)

                HStack(spacing: 30) {
                    Button("🔁 Retake") {
                        capturedImage = nil
                        showCamera = true
                    }
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .clipShape(Capsule())

                    Button("✅ Start Analyze") {
                        // Do your logic here
                        print("Start analyzing image...")
                    }
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                }
            } else {
                Button("📷 Take Photo") {
                    showCamera = true
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }
        }
        .sheet(isPresented: $showCamera) {
            ImagePicker(sourceType: .camera) { image in
                self.capturedImage = image
            }
        }
    }
}


//struct CameraView: View {
//    @State private var showCamera = false
//    @State private var image: UIImage?
//
//    var body: some View {
//        VStack {
//            if let image = image {
//                Image(uiImage: image)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(height: 300)
//            }
//
//            Button("Open Camera") {
//                showCamera = true
//            }
//            .padding()
//            .background(Color.blue)
//            .foregroundColor(.white)
//            .cornerRadius(10)
//        }
//        .sheet(isPresented: $showCamera) {
//            ImagePicker(sourceType: .camera, selectedImage: $image)
//        }
//    }
//}
#Preview {
    CameraFlowView()
}
