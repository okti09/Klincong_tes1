//
//  FinishView.swift
//  Klincong1
//
//  Created by Asri Oktianawati on 06/05/25.
//

import Foundation
import SwiftUI

struct FinishView: View {
    var body: some View {
        VStack(spacing: 20) {
            
            Image("cleaning")
                .resizable()
                .scaledToFit()
                .frame(height: 280)
            
            Text("Congratulations!")
                .font(.largeTitle)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.birumalam))
        .edgesIgnoringSafeArea(.all)
    }
}
struct FinishView_Previews: PreviewProvider {
    static var previews: some View {
        FinishView()
    }
}
