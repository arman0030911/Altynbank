import Combine
import Foundation

struct InterestRateItem: Identifiable {
    let id = UUID()
    let interestKind: String
    let deposit: String
    let rate: String
}

@MainActor
final class InterestRateViewModel: ObservableObject {
    let items: [InterestRateItem] = [
        InterestRateItem(interestKind: "Bireysel Müşteri", deposit: "1 ay", rate: "42.50%"),
        InterestRateItem(interestKind: "Kurumsal Müşteri", deposit: "3 ay", rate: "44.00%"),
        InterestRateItem(interestKind: "Bireysel Müşteri", deposit: "6 ay", rate: "45.25%"),
        InterestRateItem(interestKind: "Kurumsal Müşteri", deposit: "12 ay", rate: "46.10%"),
        InterestRateItem(interestKind: "Bireysel Müşteri", deposit: "32 gün", rate: "41.80%"),
        InterestRateItem(interestKind: "Kurumsal Müşteri", deposit: "1 ay", rate: "43.30%"),
        InterestRateItem(interestKind: "Bireysel Müşteri", deposit: "92 gün", rate: "44.90%"),
        InterestRateItem(interestKind: "Kurumsal Müşteri", deposit: "6 ay", rate: "45.70%")
    ]
}
