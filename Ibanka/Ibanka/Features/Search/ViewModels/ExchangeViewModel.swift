import Combine
import Foundation

struct CurrencyOption: Identifiable, Equatable {
    let id = UUID()
    let code: String
    let title: String
}

@MainActor
final class ExchangeViewModel: ObservableObject {
    @Published var fromAmount = ""
    @Published var toAmount = ""
    @Published var fromCurrency: CurrencyOption
    @Published var toCurrency: CurrencyOption
    @Published var showCurrencyPicker = false
    @Published var pickingFromCurrency = true

    let currencyOptions: [CurrencyOption] = [
        CurrencyOption(code: "TRY", title: "Türk Lirası"),
        CurrencyOption(code: "USD", title: "Amerikan Doları"),
        CurrencyOption(code: "EUR", title: "Euro"),
        CurrencyOption(code: "GBP", title: "İngiliz Sterlini"),
        CurrencyOption(code: "SAR", title: "Suudi Riyali"),
        CurrencyOption(code: "AED", title: "BAE Dirhemi")
    ]

    init() {
        fromCurrency = CurrencyOption(code: "TRY", title: "Türk Lirası")
        toCurrency = CurrencyOption(code: "USD", title: "Amerikan Doları")
    }

    var canExchange: Bool {
        !fromAmount.trimmingCharacters(in: .whitespaces).isEmpty &&
        !toAmount.trimmingCharacters(in: .whitespaces).isEmpty &&
        fromCurrency.code != toCurrency.code
    }

    var rateText: String {
        if fromCurrency.code == "TRY", toCurrency.code == "USD" {
            return "1 USD = 38,20 TRY"
        }
        if fromCurrency.code == "USD", toCurrency.code == "TRY" {
            return "1 USD = 38,20 TRY"
        }
        if fromCurrency.code == "EUR", toCurrency.code == "TRY" {
            return "1 EUR = 41,30 TRY"
        }
        if fromCurrency.code == "GBP", toCurrency.code == "TRY" {
            return "1 GBP = 48,50 TRY"
        }
        return "1 \(fromCurrency.code) = 1.00 \(toCurrency.code)"
    }

    func openFromPicker() {
        pickingFromCurrency = true
        showCurrencyPicker = true
    }

    func openToPicker() {
        pickingFromCurrency = false
        showCurrencyPicker = true
    }

    func selectCurrency(_ option: CurrencyOption) {
        if pickingFromCurrency {
            fromCurrency = option
        } else {
            toCurrency = option
        }
        showCurrencyPicker = false
    }
}
