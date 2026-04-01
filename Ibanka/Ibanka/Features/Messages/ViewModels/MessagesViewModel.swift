import Combine
import Foundation

struct BankThreadMessage: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let isIncoming: Bool
    let dateText: String
}

struct MessageThread: Identifiable, Equatable {
    let id = UUID()
    let bankName: String
    let preview: String
    let dateText: String
    let colorHex: String
    let messages: [BankThreadMessage]
}

@MainActor
final class MessagesViewModel: ObservableObject {
    @Published var threads: [MessageThread] = [
        MessageThread(
            bankName: "Türkiye İş Bankası",
            preview: "Güvenlik kodunuz: 256486. Kodu kimseyle paylaşmayın.",
            dateText: "Bugün",
            colorHex: "#4B3FCB",
            messages: [
                BankThreadMessage(
                    text: "İş Bankası: 256486 doğrulama kodunuzdur. Kodun geçerlilik süresi 10 dakikadır.",
                    isIncoming: true,
                    dateText: "Bugün 09:12"
                ),
                BankThreadMessage(
                    text: "Teşekkürler.",
                    isIncoming: false,
                    dateText: "Bugün 09:13"
                )
            ]
        ),
        MessageThread(
            bankName: "Akbank",
            preview: "Hesap güvenliğiniz için yeni cihaz doğrulaması yapıldı.",
            dateText: "Dün",
            colorHex: "#D06565",
            messages: [
                BankThreadMessage(
                    text: "Akbank bildirimi: Hesabınıza yeni bir cihazdan giriş yapıldı.",
                    isIncoming: true,
                    dateText: "Dün 18:40"
                )
            ]
        ),
        MessageThread(
            bankName: "Garanti BBVA",
            preview: "Ekstre bilgileriniz hazır. Mobil uygulamadan görüntüleyebilirsiniz.",
            dateText: "12/10",
            colorHex: "#6E79EA",
            messages: [
                BankThreadMessage(
                    text: "Garanti BBVA: Ekim ayı ekstreniz hazırlandı.",
                    isIncoming: true,
                    dateText: "12/10 11:05"
                )
            ]
        ),
        MessageThread(
            bankName: "Yapı Kredi",
            preview: "Kredi kartı limit güncelleme talebiniz alınmıştır.",
            dateText: "10/10",
            colorHex: "#D3AB43",
            messages: [
                BankThreadMessage(
                    text: "Yapı Kredi: Kart limit artış talebiniz değerlendirmeye alınmıştır.",
                    isIncoming: true,
                    dateText: "10/10 15:20"
                )
            ]
        ),
        MessageThread(
            bankName: "Ziraat Bankası",
            preview: "Maaş hesabınıza 24.850,00 TL yatırılmıştır.",
            dateText: "09/10",
            colorHex: "#64B59F",
            messages: [
                BankThreadMessage(
                    text: "Ziraat Bankası: Hesabınıza 24.850,00 TL maaş ödemesi yapılmıştır.",
                    isIncoming: true,
                    dateText: "09/10 08:01"
                )
            ]
        )
    ]
}

