////
////  ServiceCard.swift
////  Klincong1
////
////  Created by Asri Oktianawati on 03/05/25.
////
import Foundation
import SwiftUI

struct ServiceCard: View {
    var imageName: String
    var label: String
    var isSelected: Bool
    var onTap: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 50)
            Text(label)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.gray)
        }
        .padding()
        .frame(width: 110, height: 130)
        .background(isSelected ? Color.yellow : Color(.systemGray6))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
        .onTapGesture {
            onTap()
        }
    }
}
#Preview {
    ContentView()
}
