import Foundation

@MainActor
final class MockAuthService: AuthServiceProtocol {
    private var session: UserSession?

    init(startOnHome: Bool = true) {
        if startOnHome {
            session = UserSession(
                id: UUID(),
                fullName: "Ahmet Yılmaz",
                email: "demo@ibanka.app"
            )
        } else {
            session = nil
        }
    }

    func currentSession() async -> UserSession? {
        session
    }

    func signIn(email: String, password: String) async throws -> UserSession {
        let cleanEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !cleanEmail.isEmpty, !cleanPassword.isEmpty else {
            throw AuthServiceError.invalidCredentials
        }

        let user = UserSession(
            id: UUID(),
            fullName: "Adis Yılmaz",
            email: cleanEmail
        )

        session = user
        return user
    }

    func signOut() async throws {
        session = nil
    }
}
