//
//  InstructionOverlayView.swift
//  Klincong1
//
//  Created by Asri Oktianawati on 07/05/25.
//

import Foundation
import SwiftUI

struct InstructionOverlayView: View {
    var body: some View {
        Color.black.opacity(0.3)
            .ignoresSafeArea()
            .blur(radius: 10)
            .allowsHitTesting(false)

        VStack {
            Spacer()
            Text("Foto area yang ingin kamu bersihkan")
                .font(.headline)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding()
                .background(Color.black.opacity(0.6))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .cornerRadius(10)
                .padding(.bottom, 50)
                .allowsHitTesting(false)
        }
    }
}
