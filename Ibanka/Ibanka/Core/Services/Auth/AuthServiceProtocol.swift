import Foundation

protocol AuthServiceProtocol {
    func currentSession() async -> UserSession?
    func signIn(email: String, password: String) async throws -> UserSession
    func signOut() async throws
}

enum AuthServiceError: LocalizedError {
    case invalidCredentials

    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "E-posta ve sifre alanlari bos birakilamaz."
        }
    }
}
