import Combine
import Foundation

@MainActor
final class ChangePasswordViewModel: ObservableObject {
    @Published var newPassword = ""
    @Published var confirmPassword = ""
    @Published var isLoading = false

    var isSubmitEnabled: Bool {
        let a = newPassword.trimmingCharacters(in: .whitespacesAndNewlines)
        let b = confirmPassword.trimmingCharacters(in: .whitespacesAndNewlines)
        return !a.isEmpty && a.count >= 8 && a == b
    }
}
