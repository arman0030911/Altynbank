import SwiftUI

struct CardDetailView: View {
    let card: HomeBankCard
    let onBack: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            topBar

            VStack(spacing: 0) {
                detailRow(title: "Ad Soyad", value: card.holderName)
                detailRow(title: "Kart numarası", value: card.detailNumber)
                detailRow(title: "Geçerlilik başlangıcı", value: card.validFrom)
                detailRow(title: "Son kullanma", value: card.goodThru)
                detailRow(title: "Kullanılabilir bakiye", value: card.availableBalance)
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)

            Spacer()

            Button("Kartı sil") {}
                .buttonStyle(.plain)
                .font(.system(size: 25, weight: .semibold, design: .rounded))
                .foregroundStyle(Color(red: 0.83, green: 0.35, blue: 0.35))
                .padding(.bottom, 48)
        }
        .background(Color.white)
    }

    private var topBar: some View {
        HStack(spacing: 12) {
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.black.opacity(0.82))
            }
            .buttonStyle(.plain)

            Text("Kart")
                .font(.system(size: 34, weight: .bold, design: .rounded))
                .foregroundStyle(.black.opacity(0.82))

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .padding(.bottom, 8)
    }

    private func detailRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.black.opacity(0.46))

            Spacer()

            Text(value)
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(AppTheme.authPrimary)
        }
        .padding(.vertical, 14)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(Color.black.opacity(0.08))
                .frame(height: 1)
        }
    }
}

#Preview {
    CardDetailView(
        card: HomeViewModel(user: nil).cards[0],
        onBack: {}
    )
}
