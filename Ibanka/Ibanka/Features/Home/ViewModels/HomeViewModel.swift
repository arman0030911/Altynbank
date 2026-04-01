import Combine
import Foundation

struct HomeQuickAction: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let iconColorHex: String
}

struct HomeBankCard: Identifiable {
    let id = UUID()
    let holderName: String
    let cardType: String
    let maskedNumber: String
    let detailNumber: String
    let validFrom: String
    let goodThru: String
    let availableBalance: String
    let balance: String
    let brand: String
    let gradientStartHex: String
    let gradientEndHex: String
}

struct HomeAccount: Identifiable {
    let id = UUID()
    let title: String
    let accountNumber: String
    let balance: String
    let branch: String
}

@MainActor
final class HomeViewModel: ObservableObject {
    let userName: String
    let greeting: String
    let cards: [HomeBankCard]
    let accounts: [HomeAccount]
    let quickActions: [HomeQuickAction]

    init(user: UserSession?) {
        let name = user?.fullName.components(separatedBy: " ").first ?? "Misafir"
        userName = user?.fullName ?? "Ahmet Yılmaz"
        greeting = "Merhaba, \(name)"
        cards = [
            HomeBankCard(
                holderName: userName,
                cardType: "Vadesiz Hesap",
                maskedNumber: "4756   ••••   ••••   9018",
                detailNumber: "**** **** **** 9018",
                validFrom: "10/25",
                goodThru: "10/30",
                availableBalance: "₺10.000",
                balance: "₺3.469,52",
                brand: "VISA",
                gradientStartHex: "#312385",
                gradientEndHex: "#5B4CE0"
            ),
            HomeBankCard(
                holderName: userName,
                cardType: "Kredi Kartı",
                maskedNumber: "5214   ••••   ••••   6321",
                detailNumber: "**** **** **** 6321",
                validFrom: "06/24",
                goodThru: "06/29",
                availableBalance: "₺12.840",
                balance: "₺12.840,00",
                brand: "MASTERCARD",
                gradientStartHex: "#8A6A1A",
                gradientEndHex: "#D1B44E"
            )
        ]
        accounts = [
            HomeAccount(
                title: "Hesap 1",
                accountNumber: "TR95 0006 7000 0000 1234 56",
                balance: "₺20.000",
                branch: "Kadıköy Şubesi"
            ),
            HomeAccount(
                title: "Hesap 2",
                accountNumber: "TR47 0004 6000 0000 9876 32",
                balance: "₺12.000",
                branch: "Beşiktaş Şubesi"
            ),
            HomeAccount(
                title: "Hesap 3",
                accountNumber: "TR20 0011 1000 0000 2222 10",
                balance: "₺230.000",
                branch: "Şişli Şubesi"
            )
        ]
        quickActions = [
            HomeQuickAction(title: "Hesap ve Kart", icon: "wallet.pass.fill", iconColorHex: "#6350D9"),
            HomeQuickAction(title: "Transfer", icon: "arrow.left.arrow.right.square", iconColorHex: "#E97D7D"),
            HomeQuickAction(title: "Para Çek", icon: "building.columns", iconColorHex: "#5B8BE0"),
            HomeQuickAction(title: "Mobil Yükleme", icon: "simcard.fill", iconColorHex: "#D6A934"),
            HomeQuickAction(title: "Fatura Öde", icon: "doc.text.fill", iconColorHex: "#6AB89C"),
            HomeQuickAction(title: "Birikim", icon: "aqi.medium", iconColorHex: "#6254C7"),
            HomeQuickAction(title: "Kredi Kartı", icon: "creditcard.fill", iconColorHex: "#C9854A"),
            HomeQuickAction(title: "Rapor", icon: "list.bullet.rectangle.portrait.fill", iconColorHex: "#5E57BE"),
            HomeQuickAction(title: "Alıcı", icon: "person.text.rectangle.fill", iconColorHex: "#CC6868")
        ]
    }
}
