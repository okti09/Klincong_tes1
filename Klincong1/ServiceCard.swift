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
