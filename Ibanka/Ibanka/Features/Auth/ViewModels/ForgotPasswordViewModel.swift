import Combine
import Foundation

@MainActor
final class ForgotPasswordViewModel: ObservableObject {
    @Published var phoneNumber = ""
    @Published var isLoading = false

    var isSendEnabled: Bool {
        let digits = phoneNumber.filter(\.isNumber)
        return digits.count >= 9
    }
}
