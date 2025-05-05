//
//  ServiceCard.swift
//  Klincong1
//
//  Created by Asri Oktianawati on 03/05/25.
//
import Foundation
import SwiftUI

struct ServiceCard: View {
    var imageName: String
    var label: String
 //   @State private var selectedTools: [String] = []
    @State private var isTapped = false // Menyimpan status apakah kartu sudah diklik atau belum

    var body: some View {
      //  NavigationStack {
        VStack(spacing: 12) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 50)

            Text(label)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.black)
           
        }
        .padding()
        .frame(width: 110, height: 130)
        .background(isTapped ? Color.yellow : Color(.systemGray6))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
        .onTapGesture {
            // Mengubah status saat diklik
            withAnimation {
                isTapped.toggle()
            }
        }
    }
}
#Preview {
    ContentView()
}

//// ServiceCard: Kartu yang dapat diklik dan berubah warna
//struct ServiceCard: View {
//    var imageName: String
//    var label: String
//    @State private var isTapped = false // Menyimpan status apakah kartu sudah diklik atau belum
//
//    var body: some View {
//        VStack(spacing: 12) {
//            Image(imageName)
//                .resizable()
//                .scaledToFit()
//                .frame(height: 50)
//
//            Text(label)
//                .font(.system(size: 14, weight: .semibold))
//                .foregroundColor(.black)
//        }
//        .padding()
//        .frame(width: 120, height: 140)
//        .background(isTapped ? Color.blue : Color(.systemGray6)) // Mengubah warna berdasarkan status isTapped
//        .cornerRadius(20)
//        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
//        .onTapGesture {
//            // Mengubah status saat diklik
//            withAnimation {
//                isTapped.toggle() // Toggle status antara tapped atau tidak
//            }
//        }
//    }
//}
//
//struct TampilanUtama: View {
//    let services = [
//        ("home_cleaning", "Sapu"),
//        ("floor_cleaning", "Pel"),
//        ("dry_cleaning", "Vakum"),
//        ("glass_cleaning", "Kain Lap"),
//        ("door_cleaning", "Kemoceng"),
//        ("cloth_cleaning", "Chemical"),
//        ("cloth_cleaning", "Kain"),
//    ]
//
//    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
//
//    var body: some View {
//        ScrollView {
//            LazyVGrid(columns: columns, spacing: 20) {
//                ForEach(services, id: \.0) { service in
//                    ServiceCard(imageName: service.0, label: service.1) // Gunakan ServiceCard di sini
//                }
//            }
//            .padding()
//        }
//    }
//}

