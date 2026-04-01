import SwiftUI

private enum HomeRoute {
    case home
    case search
    case branch
    case interestRate
    case exchangeRate
    case exchange
    case messages
    case messageDetail
    case settings
    case settingsAppInfo
    case settingsChangePassword
    case report
    case accountAndCard
    case cardDetail
    case withdraw
    case transfer
    case transferConfirm
}

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    @StateObject private var messagesViewModel = MessagesViewModel()
    @State private var route: HomeRoute = .home
    @State private var selectedCardIndex = 0
    @State private var selectedThread: MessageThread?
    @State private var selectedCard: HomeBankCard?
    @State private var transferDraft = TransferDraft(
        fromAccountMasked: "**** **** 6789",
        toName: "Ayşe Demir",
        beneficiaryBank: "Türkiye İş Bankası",
        cardNumber: "0123456789",
        fee: "₺10",
        note: "Kira ödemesi",
        amount: "₺1000"
    )

    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        Group {
            switch route {
            case .home:
                homeScreen
            case .search:
                searchScreen
            case .branch:
                branchScreen
            case .interestRate:
                interestRateScreen
            case .exchangeRate:
                exchangeRateScreen
            case .exchange:
                exchangeScreen
            case .messages:
                messagesScreen
            case .messageDetail:
                messageDetailScreen
            case .settings:
                settingsScreen
            case .settingsAppInfo:
                settingsAppInfoScreen
            case .settingsChangePassword:
                settingsChangePasswordScreen
            case .report:
                reportScreen
            case .accountAndCard:
                accountAndCardScreen
            case .cardDetail:
                cardDetailScreen
            case .withdraw:
                withdrawScreen
            case .transfer:
                transferScreen
            case .transferConfirm:
                transferConfirmScreen
            }
        }
        .animation(.easeInOut(duration: 0.2), value: route)
    }

    private var homeScreen: some View {
        ZStack(alignment: .top) {
            AppTheme.authPrimary
                .ignoresSafeArea()

            VStack(spacing: 0) {
                topHeader

                VStack(spacing: 16) {
                    bankCard
                    quickActionsGrid
                    Spacer(minLength: 12)
                    bottomNav(selected: .home)
                }
                .padding(.horizontal, 14)
                .padding(.top, 12)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))
            }
        }
    }

    private var searchScreen: some View {
        VStack(spacing: 0) {
            SearchHubView(
                viewModel: SearchViewModel(),
                onBack: { route = .home },
                onBranchTap: { route = .branch },
                onInterestRateTap: { route = .interestRate },
                onExchangeRateTap: { route = .exchangeRate },
                onExchangeTap: { route = .exchange }
            )
            bottomNav(selected: .search)
        }
    }

    private var branchScreen: some View {
        VStack(spacing: 0) {
            BranchSearchView(
                viewModel: BranchSearchViewModel(),
                onBack: { route = .search }
            )
            bottomNav(selected: .branch)
        }
    }

    private var interestRateScreen: some View {
        VStack(spacing: 0) {
            InterestRateView(
                viewModel: InterestRateViewModel(),
                onBack: { route = .search }
            )
            bottomNav(selected: .search)
        }
    }

    private var exchangeRateScreen: some View {
        VStack(spacing: 0) {
            ExchangeRateView(
                viewModel: ExchangeRateViewModel(),
                onBack: { route = .search }
            )
            bottomNav(selected: .search)
        }
    }

    private var exchangeScreen: some View {
        VStack(spacing: 0) {
            ExchangeView(
                viewModel: ExchangeViewModel(),
                onBack: { route = .search }
            )
            bottomNav(selected: .search)
        }
    }

    private var transferScreen: some View {
        VStack(spacing: 0) {
            TransferView(
                viewModel: TransferViewModel(),
                onBack: { route = .home },
                onConfirm: { draft in
                    transferDraft = draft
                    route = .transferConfirm
                }
            )
            bottomNav(selected: .home)
        }
    }

    private var transferConfirmScreen: some View {
        VStack(spacing: 0) {
            ConfirmTransferView(
                viewModel: ConfirmTransferViewModel(draft: transferDraft),
                onBack: { route = .transfer }
            )
            bottomNav(selected: .home)
        }
    }

    private var messagesScreen: some View {
        VStack(spacing: 0) {
            MessagesListView(
                viewModel: messagesViewModel,
                onBack: { route = .home },
                onOpenThread: { thread in
                    selectedThread = thread
                    route = .messageDetail
                }
            )
            bottomNav(selected: .messages)
        }
    }

    private var messageDetailScreen: some View {
        VStack(spacing: 0) {
            if let selectedThread {
                MessageThreadView(
                    thread: selectedThread,
                    onBack: { route = .messages }
                )
            } else {
                Color.white
            }
            bottomNav(selected: .messages)
        }
    }

    private var settingsScreen: some View {
        VStack(spacing: 0) {
            SettingsView(
                userName: viewModel.userName,
                onBack: { route = .home },
                onPasswordTap: { route = .settingsChangePassword },
                onAppInfoTap: { route = .settingsAppInfo }
            )
            bottomNav(selected: .settings)
        }
    }

    private var settingsAppInfoScreen: some View {
        VStack(spacing: 0) {
            AppInfoView(onBack: { route = .settings })
            bottomNav(selected: .settings)
        }
    }

    private var settingsChangePasswordScreen: some View {
        VStack(spacing: 0) {
            SettingsChangePasswordView(onBack: { route = .settings })
            bottomNav(selected: .settings)
        }
    }

    private var reportScreen: some View {
        ReportView(onBack: { route = .home })
    }

    private var accountAndCardScreen: some View {
        AccountAndCardView(
            viewModel: viewModel,
            selectedCardIndex: $selectedCardIndex,
            onBack: { route = .home },
            onOpenCard: { card in
                selectedCard = card
                route = .cardDetail
            }
        )
    }

    private var cardDetailScreen: some View {
        Group {
            if let selectedCard {
                CardDetailView(card: selectedCard, onBack: { route = .accountAndCard })
            } else {
                Color.white
            }
        }
    }

    private var withdrawScreen: some View {
        WithdrawView(
            viewModel: WithdrawViewModel(cards: viewModel.cards),
            onBack: { route = .home }
        )
    }

    private var topHeader: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(Color.white.opacity(0.9))
                .frame(width: 32, height: 32)
                .overlay(
                    Text("A")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(AppTheme.authPrimary)
                )

            VStack(alignment: .leading, spacing: 1) {
                Text("Merhaba,")
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.white.opacity(0.8))

                Text(viewModel.userName)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.white)
            }

            Spacer()

            ZStack(alignment: .topTrailing) {
                Image(systemName: "bell.fill")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.white)

                Circle()
                    .fill(Color.red)
                    .frame(width: 8, height: 8)
                    .offset(x: 2, y: -2)
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .padding(.bottom, 12)
    }

    private var bankCard: some View {
        TabView(selection: $selectedCardIndex) {
            ForEach(Array(viewModel.cards.enumerated()), id: \.offset) { index, card in
                BankCardView(card: card)
                    .tag(index)
                    .padding(.bottom, 10)
            }
        }
        .frame(height: 196)
        .tabViewStyle(.page(indexDisplayMode: .always))
    }

    private var quickActionsGrid: some View {
        LazyVGrid(
            columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 3),
            spacing: 10
        ) {
            ForEach(viewModel.quickActions) { action in
                Button {
                    if action.title == "Hesap ve Kart" {
                        route = .accountAndCard
                    } else if action.title == "Transfer" {
                        route = .transfer
                    } else if action.title == "Para Çek" {
                        route = .withdraw
                    } else if action.title == "Rapor" {
                        route = .report
                    }
                } label: {
                    VStack(spacing: 10) {
                        Image(systemName: action.icon)
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundStyle(Color(hex: action.iconColorHex))
                            .frame(width: 30, height: 30)

                        Text(action.title)
                            .font(.system(size: 11, weight: .medium))
                            .foregroundStyle(.black.opacity(0.56))
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .minimumScaleFactor(0.9)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 84)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .overlay {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(Color.black.opacity(0.04), lineWidth: 1)
                    }
                }
                .buttonStyle(.plain)
            }
        }
    }

    private func bottomNav(selected: HomeRoute) -> some View {
        HStack {
            navButton(icon: "house.fill", title: "Ana Sayfa", isSelected: selected == .home) {
                route = .home
            }
            Spacer()
            navButton(
                icon: "magnifyingglass",
                title: selected == .branch ? "Şube" : "Arama",
                isSelected: selected == .search || selected == .branch
            ) {
                route = .search
            }
            Spacer()
            navButton(icon: "envelope", title: "Mesaj", isSelected: selected == .messages) {
                route = .messages
            }
            Spacer()
            navButton(
                icon: "gearshape",
                title: "Ayar",
                isSelected: selected == .settings || selected == .settingsAppInfo || selected == .settingsChangePassword
            ) {
                route = .settings
            }
        }
        .padding(.horizontal, 18)
        .padding(.top, 12)
        .padding(.bottom, 18)
        .background(AppTheme.background)
    }

    private func navButton(icon: String, title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            if isSelected {
                HStack(spacing: 7) {
                    Image(systemName: icon)
                        .font(.system(size: 12, weight: .bold))
                    Text(title)
                        .font(.system(size: 11, weight: .semibold))
                }
                .foregroundStyle(.white)
                .padding(.horizontal, 11)
                .padding(.vertical, 8)
                .background(AppTheme.authPrimary)
                .clipShape(Capsule())
            } else {
                Image(systemName: icon)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(.black.opacity(0.35))
            }
        }
        .buttonStyle(.plain)
    }
}

struct BankCardView: View {
    let card: HomeBankCard

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(hex: card.gradientStartHex),
                            Color(hex: card.gradientEndHex)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            Circle()
                .fill(Color.white.opacity(0.20))
                .frame(width: 132, height: 132)
                .offset(x: 100, y: -44)

            VStack(alignment: .leading, spacing: 8) {
                Text(card.holderName)
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)

                Text(card.cardType)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(.white.opacity(0.78))

                Text(card.maskedNumber)
                    .font(.system(size: 15, weight: .semibold, design: .monospaced))
                    .foregroundStyle(.white.opacity(0.9))

                HStack {
                    Text(card.balance)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(.white)

                    Spacer()

                    Text(card.brand)
                        .font(.system(size: 23, weight: .black, design: .rounded))
                        .foregroundStyle(.white)
                }
                .padding(.top, 2)
            }
            .padding(22)
        }
        .frame(height: 184)
        .overlay(alignment: .bottom) {
            RoundedRectangle(cornerRadius: 2, style: .continuous)
                .fill(Color(red: 0.76, green: 0.35, blue: 0.35).opacity(0.72))
                .frame(width: 220, height: 6)
                .offset(y: 9)
        }
    }
}

private extension Color {
    init(hex: String) {
        let string = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: string).scanHexInt64(&int)
        let r, g, b: UInt64
        switch string.count {
        case 6:
            (r, g, b) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: 1
        )
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(user: nil))
}
