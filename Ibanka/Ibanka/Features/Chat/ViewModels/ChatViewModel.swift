import Combine
import SwiftUI

@MainActor
final class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage]
    @Published var draftMessage = ""

    init(messages: [ChatMessage] = [
        ChatMessage(id: UUID(), text: "Merhaba, bugün nasıl yardımcı olabilirim?", isFromUser: false, sentAt: .now),
        ChatMessage(id: UUID(), text: "Harcamalarımı kategori bazında görmek istiyorum.", isFromUser: true, sentAt: .now),
        ChatMessage(id: UUID(), text: "Tabii, sana bunu özet ekranında hazırlayabilirim.", isFromUser: false, sentAt: .now)
    ]) {
        self.messages = messages
    }

    func sendMessage() {
        let cleanDraft = draftMessage.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleanDraft.isEmpty else { return }

        messages.append(
            ChatMessage(id: UUID(), text: cleanDraft, isFromUser: true, sentAt: .now)
        )

        messages.append(
            ChatMessage(
                id: UUID(),
                text: "Bu alan daha sonra gerçek sohbet servisine bağlanacak.",
                isFromUser: false,
                sentAt: .now
            )
        )

        draftMessage = ""
    }
}
