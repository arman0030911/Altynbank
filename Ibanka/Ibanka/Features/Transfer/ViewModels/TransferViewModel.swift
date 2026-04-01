import Combine
import Foundation

struct TransferDraft {
    let fromAccountMasked: String
    let toName: String
    let beneficiaryBank: String
    let cardNumber: String
    let fee: String
    let note: String
    let amount: String
}

struct TransferType: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
}

struct Beneficiary: Identifiable {
    let id = UUID()
    let name: String
    let avatarSymbol: String
}

@MainActor
final class TransferViewModel: ObservableObject {
    @Published var account = ""
    @Published var selectedTransferTypeID: UUID?
    @Published var selectedBeneficiaryID: UUID?
    @Published var selectedBank = ""
    @Published var branch = ""
    @Published var showBankPicker = false
    @Published var bankSearchQuery = ""
    @Published var name = ""
    @Published var cardNumber = ""
    @Published var amount = ""
    @Published var content = ""
    @Published var saveBeneficiary = false

    let transferTypes: [TransferType] = [
        TransferType(title: "Kart numarasıyla\ntransfer", icon: "creditcard.fill"),
        TransferType(title: "Aynı bankaya\ntransfer", icon: "person.fill"),
        TransferType(title: "Başka bankaya\ntransfer", icon: "building.columns.fill")
    ]

    let beneficiaries: [Beneficiary] = [
        Beneficiary(name: "Ayşe", avatarSymbol: "person.crop.circle.fill"),
        Beneficiary(name: "Mehmet", avatarSymbol: "person.crop.circle")
    ]

    let turkishBanks: [String] = [
        "Türkiye İş Bankası",
        "Ziraat Bankası",
        "Halkbank",
        "VakıfBank",
        "Garanti BBVA",
        "Akbank",
        "Yapı Kredi",
        "QNB Finansbank",
        "DenizBank",
        "TEB",
        "Şekerbank",
        "Kuveyt Türk",
        "Albaraka Türk",
        "Türkiye Finans",
        "Anadolubank",
        "ING Türkiye"
    ]

    var filteredBanks: [String] {
        let query = bankSearchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return turkishBanks }
        return turkishBanks.filter { $0.localizedCaseInsensitiveContains(query) }
    }

    var isAnotherBankTransferSelected: Bool {
        guard let selectedTransferTypeID else { return false }
        guard let selected = transferTypes.first(where: { $0.id == selectedTransferTypeID }) else { return false }
        return selected.title.contains("Başka bankaya")
    }

    var isConfirmEnabled: Bool {
        !account.isEmpty &&
        selectedTransferTypeID != nil &&
        selectedBeneficiaryID != nil &&
        (!isAnotherBankTransferSelected || !selectedBank.isEmpty) &&
        !name.trimmingCharacters(in: .whitespaces).isEmpty &&
        !cardNumber.trimmingCharacters(in: .whitespaces).isEmpty &&
        !amount.trimmingCharacters(in: .whitespaces).isEmpty &&
        !content.trimmingCharacters(in: .whitespaces).isEmpty
    }

    func makeDraft() -> TransferDraft {
        let suffix = account.suffix(4)
        let from = suffix.isEmpty ? "**** **** 6789" : "**** **** \(suffix)"
        return TransferDraft(
            fromAccountMasked: from,
            toName: name.isEmpty ? "Ayşe Demir" : name,
            beneficiaryBank: selectedBank.isEmpty ? "Türkiye İş Bankası" : selectedBank,
            cardNumber: cardNumber.isEmpty ? "0123456789" : cardNumber,
            fee: "₺10",
            note: content.isEmpty ? "Kira ödemesi" : content,
            amount: amount.isEmpty ? "₺1000" : amount
        )
    }
}
