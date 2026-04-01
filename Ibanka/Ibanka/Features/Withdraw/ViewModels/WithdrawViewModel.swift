import Combine
import Foundation

struct WithdrawAccount: Identifiable {
    let id = UUID()
    let label: String
}

@MainActor
final class WithdrawViewModel: ObservableObject {
    @Published var selectedAccountLabel: String = ""
    @Published var phoneNumber = ""
    @Published var selectedAmount: Int?
    @Published var customAmount = ""
    @Published var showAccountPicker = false
    @Published var isOtherSelected = false

    let amountOptions: [Int] = [100, 500, 1000, 1500, 2000]
    let accounts: [WithdrawAccount]

    init(cards: [HomeBankCard]) {
        let mapped = cards.map {
            WithdrawAccount(label: "\($0.brand) \($0.detailNumber)")
        }
        if mapped.isEmpty {
            accounts = [
                WithdrawAccount(label: "VISA **** **** **** 1234"),
                WithdrawAccount(label: "VISA **** **** **** 5678")
            ]
        } else {
            accounts = mapped + [
                WithdrawAccount(label: "Hesap TR95 0006 7000 0000 1234 56"),
                WithdrawAccount(label: "Hesap TR47 0004 6000 0000 9876 32")
            ]
        }
    }

    var isVerifyEnabled: Bool {
        !selectedAccountLabel.isEmpty &&
        !phoneNumber.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        (selectedAmount != nil || !customAmount.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
    }

    func selectAmount(_ amount: Int) {
        selectedAmount = amount
        isOtherSelected = false
        customAmount = ""
    }

    func selectOtherAmount() {
        selectedAmount = nil
        isOtherSelected = true
    }
}
