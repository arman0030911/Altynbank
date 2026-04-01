import Combine
import SwiftUI

enum RootAuthState {
    case loading
    case signedOut
    case signedIn
}

enum AppTab: Hashable {
    case home
    case chat
    case profile

    var title: String {
        switch self {
        case .home:
            return "Ana Sayfa"
        case .chat:
            return "Sohbet"
        case .profile:
            return "Profil"
        }
    }

    var systemImage: String {
        switch self {
        case .home:
            return "house"
        case .chat:
            return "message"
        case .profile:
            return "person"
        }
    }
}

@MainActor
final class RootViewModel: ObservableObject {
    @Published private(set) var authState: RootAuthState = .loading
    @Published private(set) var currentUser: UserSession?
    @Published var selectedTab: AppTab = .home

    private let authService: AuthServiceProtocol

    init(authService: AuthServiceProtocol) {
        self.authService = authService
        Task {
            await restoreSession()
        }
    }

    func restoreSession() async {
        currentUser = await authService.currentSession()
        authState = currentUser == nil ? .signedOut : .signedIn
    }

    func signIn(email: String, password: String) async throws {
        let session = try await authService.signIn(email: email, password: password)
        currentUser = session
        authState = .signedIn
    }

    func signOut() async {
        do {
            try await authService.signOut()
            currentUser = nil
            authState = .signedOut
            selectedTab = .home
        } catch {
            assertionFailure("Sign out failed: \(error.localizedDescription)")
        }
    }
}
