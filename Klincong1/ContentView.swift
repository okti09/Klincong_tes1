//
//  ContentView.swift
//  Klincong1
//
//  Created by Asri Oktianawati on 03/05/25.
//

import SwiftUI

struct ContentView: View {
    @State private var navigateToTasks = false
    
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
      //  NavigationLink {
            ScrollView {
                VStack {
                    // Menambahkan teks di atas grid
                    Text("Choose Your\n Cleaning Tools")
                        .font(.title) // Mengatur ukuran font untuk judul
                        .foregroundStyle(.white)
                        .fontWeight(.bold) // Memberikan ketebalan font
                        .padding(.top, 20) // Menambahkan jarak di atas teks
                    
                    // Grid untuk menampilkan alat bersih-bersih
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(selectedTools, id: \.0) { selectedTools in
                            ServiceCard(imageName: selectedTools.0, label: selectedTools.1)
                            
                        }
                    }
                  //  .frame(maxWidth: .infinity) // Grid terletak di tengah secara horizontal
                    .padding() // Memberikan sedikit padding di sekitar grid
                    
                    Button(action: {
                        navigateToTasks = true
                    }) {
                     //   NavigationLink(destination: CardTaskView()) {
                            Text("Done")
                                .fontWeight(.bold)
                                .padding()
                                .frame(maxWidth: 220)
                                .background(
                                    LinearGradient( gradient: Gradient(colors: [Color.orange, Color.yellow]),
                                                    startPoint: .leading,
                                                    endPoint: .trailing )
                                )
                                .foregroundColor(.white)
                                .cornerRadius(30)
                        
                        }
                    }
                }
          //  }
            .padding()
            //.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.hijaumalam))
        }
    }

#Preview {
    ContentView()
}
