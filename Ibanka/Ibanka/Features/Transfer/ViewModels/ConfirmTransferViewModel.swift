import Combine
import Foundation
import LocalAuthentication

@MainActor
final class ConfirmTransferViewModel: ObservableObject {
    let draft: TransferDraft

    @Published var otp = ""
    @Published var isProcessing = false
    @Published var authErrorMessage: String?

    init(draft: TransferDraft) {
        self.draft = draft
    }

    var canRequestOTP: Bool {
        !otp.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var canConfirm: Bool {
        canRequestOTP
    }

    func confirmWithAuthentication() async -> Bool {
        isProcessing = true
        authErrorMessage = nil
        defer { isProcessing = false }

        let context = LAContext()
        var error: NSError?
        let reason = "Transfer işlemini onaylamak için kimliğini doğrula."

        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            return true
        }

        let result = await withCheckedContinuation { continuation in
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, _ in
                continuation.resume(returning: success)
            }
        }

        if !result {
            authErrorMessage = "Kimlik doğrulama başarısız. Lütfen tekrar deneyin."
        }
        return result
    }
}
