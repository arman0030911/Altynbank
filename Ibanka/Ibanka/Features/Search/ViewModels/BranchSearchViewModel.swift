import Combine
import Foundation

struct BranchItem: Identifiable {
    let id = UUID()
    let name: String
    let distance: String
}

@MainActor
final class BranchSearchViewModel: ObservableObject {
    @Published var query = ""

    let branches: [BranchItem] = [
        BranchItem(name: "Türkiye İş Bankası - Kadıköy Şubesi", distance: "350 m"),
        BranchItem(name: "Akbank - Beşiktaş Şubesi", distance: "1,2 km"),
        BranchItem(name: "Garanti BBVA - Şişli Şubesi", distance: "2,1 km"),
        BranchItem(name: "Yapı Kredi - Üsküdar Şubesi", distance: "2,8 km"),
        BranchItem(name: "Ziraat Bankası - Ataşehir Şubesi", distance: "3,4 km")
    ]
}
