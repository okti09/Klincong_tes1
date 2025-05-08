import SwiftUI

struct HomePageView: View {
    var onStartCapture: (() -> Void)? = nil
    var onCleaningTools: (() -> Void)? = nil
    var body: some View {
        ZStack {
            Image("bg_homepage")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack {
                Spacer()
                Image("cat_homepage")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 260)
                    .padding(.top, 24)
                Spacer()
                    .frame(height: 270)
                Spacer()
                VStack(spacing: 20) {
                    Button(action: { onStartCapture?() }) {
                        Text("START CAPTURE TO CLEAN")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.orange)
                            .cornerRadius(32)
                    }
                    Button(action: { onCleaningTools?() }) {
                        Text("MY CLEANING TOOLS")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color(red: 1.0, green: 0.95, blue: 0.7))
                            .cornerRadius(32)
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 72)
                Spacer()
            }
        }
    }
}

#Preview {
    HomePageView()
} 
