//
//  ContentView.swift
//  cleaningAsistant
//
//  Created by Asri Oktianawati on 09/04/25.
//

import SwiftUI

struct Landingpage: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                Text("Let's Begin\n Your Cleaning")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                //.padding()
                
                Image("cleaning")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 280)
                
                //            Text("Get ready to  make your life easier with single click of app and make your cleaning fun!")
                //                .foregroundColor(.white)
                //                .multilineTextAlignment(.center)
                //                .font(.body)
                //                .padding(.horizontal, 30)
                //                .padding()
                //
                Button(action: {
                    print("Button tapped!")
                }) {
                    NavigationLink(destination: ContentView()) {
                        Text("Get Started")
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
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.hijaumalam))
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct Landingpage_Previews: PreviewProvider {
    static var previews: some View {
        Landingpage()
    }
}
