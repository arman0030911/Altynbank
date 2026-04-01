import Combine
import SwiftUI

struct ProfileRow: Identifiable {
    let id = UUID()
    let title: String
    let value: String
}

@MainActor
final class ProfileViewModel: ObservableObject {
    let displayName: String
    let initials: String
    let rows: [ProfileRow]

    private let signOutAction: () async -> Void

    init(user: UserSession?, signOutAction: @escaping () async -> Void) {
        displayName = user?.fullName ?? "Misafir Kullanıcı"
        initials = user?.initials.isEmpty == false ? user?.initials ?? "MK" : "MK"
        rows = [
            ProfileRow(title: "E-posta", value: user?.email ?? "ornek@ibanka.app"),
            ProfileRow(title: "Dil", value: "Türkçe"),
            ProfileRow(title: "Bölge", value: "Türkiye")
        ]
        self.signOutAction = signOutAction
    }

    func signOut() async {
        await signOutAction()
    }
}
