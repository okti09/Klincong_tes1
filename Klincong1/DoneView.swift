//
//  DoneView.swift
//  Klincong1
//
//  Created by Asri Oktianawati on 06/05/25.
//
import Foundation
import SwiftUI

struct DoneView: View {
    var body: some View {
        VStack(spacing: 20) {
            
            Image("cleaning")
                .resizable()
                .scaledToFit()
                .frame(height: 280)
            
            Text("Well Done!\n You're doing good")
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
struct DoneView_Previews: PreviewProvider {
    static var previews: some View {
        DoneView()
    }
}
