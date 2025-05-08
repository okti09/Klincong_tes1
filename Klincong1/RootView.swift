import SwiftUI

struct RootView: View {
    @State private var showLanding = true

    var body: some View {
        if showLanding {
            LandingPageView {
                withAnimation {
                    showLanding = false
                }
            }
        } else {
            ContentView()
        }
    }
}
