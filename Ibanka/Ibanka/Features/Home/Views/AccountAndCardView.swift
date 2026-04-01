import SwiftUI

private enum AccountCardTab {
    case account
    case card
}

struct AccountAndCardView: View {
    @ObservedObject var viewModel: HomeViewModel
    @Binding var selectedCardIndex: Int
    let onBack: () -> Void
    let onOpenCard: (HomeBankCard) -> Void

    @State private var selectedTab: AccountCardTab = .account

    var body: some View {
        VStack(spacing: 0) {
            topBar

            ScrollView(showsIndicators: false) {
                VStack(spacing: 14) {
                    tabSwitcher

                    if selectedTab == .account {
                        accountContent
                    } else {
                        cardContent
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 10)
                .padding(.bottom, 24)
            }
        }
        .background(AppTheme.background)
    }

    private var topBar: some View {
        HStack(spacing: 12) {
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.black.opacity(0.8))
            }
            .buttonStyle(.plain)

            Text("Hesap ve Kart")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .foregroundStyle(.black.opacity(0.85))

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .padding(.bottom, 10)
        .background(Color.white)
    }

    private var tabSwitcher: some View {
        HStack(spacing: 10) {
            tabButton(title: "Hesap", tab: .account)
            tabButton(title: "Kart", tab: .card)
        }
    }

    private func tabButton(title: String, tab: AccountCardTab) -> some View {
        Button {
            selectedTab = tab
        } label: {
            Text(title)
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(selectedTab == tab ? .white : .black.opacity(0.58))
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .background(selectedTab == tab ? AppTheme.authPrimary : Color.black.opacity(0.08))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .buttonStyle(.plain)
    }

    private var accountContent: some View {
        VStack(spacing: 10) {
            ForEach(viewModel.accounts) { account in
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(account.title)
                            .font(.system(size: 24, weight: .bold, design: .rounded))
                            .foregroundStyle(.black.opacity(0.84))
                        Spacer()
                        Text(account.accountNumber)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(.black.opacity(0.72))
                    }

                    HStack {
                        Text("Bakiye")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(.black.opacity(0.45))
                        Spacer()
                        Text(account.balance)
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(AppTheme.authPrimary)
                    }

                    HStack {
                        Text("Şube")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(.black.opacity(0.45))
                        Spacer()
                        Text(account.branch)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(AppTheme.authPrimary)
                    }
                }
                .padding(12)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                .overlay {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .stroke(Color.black.opacity(0.05), lineWidth: 1)
                }
            }
        }
    }

    private var cardContent: some View {
        VStack(spacing: 12) {
            ForEach(viewModel.cards) { card in
                Button {
                    onOpenCard(card)
                } label: {
                    BankCardView(card: card)
                }
                .buttonStyle(.plain)
            }

            Button("Kart Ekle") {}
                .buttonStyle(.plain)
                .font(.system(size: 24, weight: .semibold, design: .rounded))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(AppTheme.authPrimary)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                .padding(.top, 4)
        }
    }
}

#Preview {
    AccountAndCardView(
        viewModel: HomeViewModel(user: nil),
        selectedCardIndex: .constant(0),
        onBack: {},
        onOpenCard: { _ in }
    )
}
