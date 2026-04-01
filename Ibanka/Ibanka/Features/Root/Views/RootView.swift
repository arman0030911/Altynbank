import SwiftUI

struct RootView: View {
    @ObservedObject var viewModel: RootViewModel

    var body: some View {
        Group {
            switch viewModel.authState {
            case .loading:
                ProgressView("Yükleniyor...")
                    .tint(AppTheme.accent)
            case .signedOut:
                AuthView(
                    viewModel: AuthViewModel { email, password in
                        try await viewModel.signIn(email: email, password: password)
                    }
                )
            case .signedIn:
                mainTabs
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppTheme.background)
    }

    private var mainTabs: some View {
        HomeView(viewModel: HomeViewModel(user: viewModel.currentUser))
    }
}

#Preview {
    RootView(viewModel: RootViewModel(authService: MockAuthService()))
}
