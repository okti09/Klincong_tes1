import SwiftUI

struct RootView: View {
    @State private var showLanding = true

    var body: some View {
        if showLanding {
            LandingPageView {
                // Ketika tombol GET STARTED ditekan
                withAnimation {
                    showLanding = false
                }
            }
        } else {
            ContentView()
        }
    }
}
