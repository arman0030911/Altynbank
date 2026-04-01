import Foundation

struct ChatMessage: Identifiable, Equatable {
    let id: UUID
    let text: String
    let isFromUser: Bool
    let sentAt: Date
}
