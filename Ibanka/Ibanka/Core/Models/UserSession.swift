import Foundation

struct UserSession: Identifiable, Equatable {
    let id: UUID
    let fullName: String
    let email: String

    var initials: String {
        let parts = fullName.split(separator: " ")
        let letters = parts.prefix(2).compactMap(\.first)
        return String(letters)
    }
}
