import SwiftUI

struct LandingPageView: View {
    var onGetStarted: (() -> Void)? = nil
    var body: some View {
        ZStack {
            Image("landing_page")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            VStack() {
                Spacer()
                Button(action: {
                    onGetStarted?()
                }) {
                    Text("GET STARTED")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 48)
                        .padding(.vertical, 16)
                        .background(Color.orange)
                        .cornerRadius(32)
                }
                .padding(.bottom, 100)
            }
        }
    }
}

#Preview {
    LandingPageView()
} 