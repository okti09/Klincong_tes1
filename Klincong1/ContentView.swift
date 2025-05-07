//
//  ContentView.swift
//  Klincong1
//
//  Created by Asri Oktianawati on 03/05/25.
//

import SwiftUI

struct ToolItem: Identifiable, Hashable {
    let id = UUID()
    let icon: String
    let name: String
}

struct ContentView: View {
    @State private var path: [Route] = []
    @State private var image: UIImage?
    @State private var showInstructions = true

    let selectedTools = [
        ("alat_Sapu", "Sapu"),
        ("alat_Pel", "Pel"),
        ("alat_vakum", "Vakum"),
        ("alat_KainLap", "Kain Lap"),
        ("alat_Kemoceng", "Kemoceng"),
        ("alat_Pengki", "Pengki"),
        ("alat_SikatWC", "Sikat WC"),
        ("alat_Trashbin", "Tempat Sampah"),
        ("alat_Spons", "Spons")
    ]

    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack {
                    Text("Choose Your\n Cleaning Tools")
                        .font(.title)
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.center)
                        .fontWeight(.bold)
                        .padding(.top, 20)

                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(selectedTools, id: \.0) { tool in
                            ServiceCard(imageName: tool.0, label: tool.1)
                        }
                    }
                    .padding()

                    Button(action: {
                        if selectedTools.count >= 1 {
                            showInstructions = true
                            path.append(.camera)
                        }
                    }) {
                        Text("Done")
                            .fontWeight(.bold)
                            .padding()
                            .frame(maxWidth: 220)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color.orange, Color.yellow]),
                                               startPoint: .leading,
                                               endPoint: .trailing)
                            )
                            .foregroundColor(.gray)
                            .cornerRadius(30)
                            .padding()
                    }
                }
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .camera:
                        ZStack {
                            CameraView { capturedImage in
                                self.image = capturedImage
                                self.showInstructions = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    path.removeLast() // 2️⃣ Baru keluar dari kamera
                                }
                                //path.removeLast()
                            }

                            if showInstructions {
                                InstructionOverlayView()
                            }
                        }
                        .navigationBarBackButtonHidden(true)
                    }
                }
            }
        }
    }
}
#Preview {
    ContentView()
}


//struct ToolItem: Identifiable, Hashable{
//    let id = UUID()
//    let icon: String
//    let name: String
//}
//
//struct ContentView: View {
//    @State private var navigateToTasks = false
//    @State private var showInstructions = true
//    @State private var path: [Route] = []
//    @State private var image: UIImage?
//    
//    let selectedTools = [
//        ("alat_Sapu", "Sapu"),
//        ("alat_Pel", "Pel"),
//        ("alat_vakum", "Vakum"),
//        ("alat_KainLap", "Kain Lap"),
//        ("alat_Kemoceng", "Kemoceng"),
//        ("alat_Pengki", "Pengki"),
//        ("alat_SikatWC", "Sikat WC"),
//        ("alat_Trashbin", "Tempat Sampah"),
//        ("alat_Spons", "Spons")
//    ]
//    
//    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
//    
//    var body: some View {
//        NavigationStack(path: $path) {
//            ScrollView {
//                VStack {
//                    // Menambahkan teks di atas grid
//                    Text("Choose Your\n Cleaning Tools")
//                        .font(.title) // Mengatur ukuran font untuk judul
//                        .foregroundStyle(.gray)
//                        .multilineTextAlignment(.center)
//                        .fontWeight(.bold) // Memberikan ketebalan font
//                        .padding(.top, 20) // Menambahkan jarak di atas teks
//                    
//                    // Grid untuk menampilkan alat bersih-bersih
//                    LazyVGrid(columns: columns, spacing: 20) {
//                        ForEach(selectedTools, id: \.0) { selectedTools in
//                            ServiceCard(imageName: selectedTools.0, label: selectedTools.1)
//                            
//                        }
//                    }
//                    .padding() // Memberikan sedikit padding di sekitar grid
//                    
//                    Button(action: {
//                        if selectedTools.count >= 1 {
//                            // saveToUserDefaults()
//                            path.append(.camera)
//                        }
//                    }) {
//                        Text("Done")
//                            .fontWeight(.bold)
//                            .padding()
//                            .disabled(selectedTools.count < 1)
//                            .frame(maxWidth: 220)
//                            .background(
//                                LinearGradient( gradient: Gradient(colors: [Color.orange, Color.yellow]),
//                                                startPoint: .leading,
//                                                endPoint: .trailing )
//                            )
//                            .foregroundColor(.gray)
//                            .cornerRadius(30)
//                            .padding()
//                    }
//                }
//                
//                .navigationDestination(for: Route.self) { route in
//                    switch route {
//                    case .camera:
//                        ZStack {
//                            CameraView { capturedImage in
//                                self.image = capturedImage
//                                showInstructions = false // Sembunyikan instruksi
//                                path.removeLast()
//                            }
//                            
//                            // Blur background kamera
//                            Color.black.opacity(0.3)
//                                .ignoresSafeArea()
//                                .blur(radius: 10)
//                                .allowsHitTesting(false)
//                            
//                            if showInstructions {
//                                Color.black.opacity(0.3)
//                                    .ignoresSafeArea()
//                                    .blur(radius: 10)
//                                    .allowsHitTesting(false)
//                                
//                                VStack {
//                                    Spacer()
//                                    Text("Foto area yang ingin kamu bersihkan")
//                                        .font(.headline)
//                                    // .multilineTextAlignment(.center)
//                                        .foregroundColor(.white)
//                                        .padding()
//                                        .background(Color.black.opacity(0.6))
//                                        .cornerRadius(10)
//                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                                        .allowsHitTesting(false)
//                                }
//                                .navigationBarBackButtonHidden(true)
//                            }
//                        }
//                    }
//                }
//            }
//            
//        }
//    }
//    //.padding()
//    //.frame(maxWidth: .infinity, maxHeight: .infinity)
//    // .background(Color(.birumalam))
//}
//
//
//#Preview {
//    ContentView()
//}
