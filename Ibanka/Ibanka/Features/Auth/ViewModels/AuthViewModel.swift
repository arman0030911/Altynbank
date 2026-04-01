import Combine
import SwiftUI

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let signInAction: (String, String) async throws -> Void

    init(signInAction: @escaping (String, String) async throws -> Void) {
        self.signInAction = signInAction
    }

    var isFormValid: Bool {
        !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !password.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func signIn() async {
        guard !isLoading else { return }

        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        do {
            try await signInAction(email, password)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
