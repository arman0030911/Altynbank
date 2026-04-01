import Combine
import Foundation

struct SearchFeatureItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let imageName: String
}

@MainActor
final class SearchViewModel: ObservableObject {
    let features: [SearchFeatureItem] = [
        SearchFeatureItem(
            title: "Şube",
            subtitle: "Size en yakın şubeyi bulun",
            imageName: "building.columns"
        ),
        SearchFeatureItem(
            title: "Faiz Oranı",
            subtitle: "Günlük faiz oranlarını inceleyin",
            imageName: "chart.line.uptrend.xyaxis"
        ),
        SearchFeatureItem(
            title: "Döviz Kuru",
            subtitle: "Güncel döviz kurlarını görün",
            imageName: "dollarsign.arrow.circlepath"
        ),
        SearchFeatureItem(
            title: "Döviz Çevirici",
            subtitle: "Tutar çevirisi yapın",
            imageName: "coloncurrencysign.arrow.circlepath"
        )
    ]
}
