import SwiftUI

struct AppContainerView: View {
    @StateObject private var rootViewModel = RootViewModel(authService: MockAuthService())

    var body: some View {
        RootView(viewModel: rootViewModel)
    }
}

#Preview {
    AppContainerView()
}
