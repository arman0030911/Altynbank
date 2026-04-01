import Combine
import Foundation

struct ExchangeRateItem: Identifiable {
    let id = UUID()
    let flag: String
    let country: String
    let buy: String
    let sell: String
}

@MainActor
final class ExchangeRateViewModel: ObservableObject {
    let items: [ExchangeRateItem] = [
        ExchangeRateItem(flag: "🇺🇸", country: "ABD Doları", buy: "38,10", sell: "38,45"),
        ExchangeRateItem(flag: "🇪🇺", country: "Euro", buy: "41,20", sell: "41,55"),
        ExchangeRateItem(flag: "🇬🇧", country: "İngiliz Sterlini", buy: "48,30", sell: "48,80"),
        ExchangeRateItem(flag: "🇸🇦", country: "Suudi Riyali", buy: "10,10", sell: "10,28"),
        ExchangeRateItem(flag: "🇦🇪", country: "BAE Dirhemi", buy: "10,34", sell: "10,52"),
        ExchangeRateItem(flag: "🇨🇭", country: "İsviçre Frangı", buy: "42,80", sell: "43,20"),
        ExchangeRateItem(flag: "🇯🇵", country: "Japon Yeni", buy: "0,25", sell: "0,27"),
        ExchangeRateItem(flag: "🇶🇦", country: "Katar Riyali", buy: "10,44", sell: "10,63")
    ]
}
