import SwiftUI

struct SearchHubView: View {
    @StateObject private var viewModel: SearchViewModel
    let onBack: () -> Void
    let onBranchTap: () -> Void
    let onInterestRateTap: () -> Void
    let onExchangeRateTap: () -> Void
    let onExchangeTap: () -> Void

    init(
        viewModel: SearchViewModel,
        onBack: @escaping () -> Void,
        onBranchTap: @escaping () -> Void,
        onInterestRateTap: @escaping () -> Void,
        onExchangeRateTap: @escaping () -> Void,
        onExchangeTap: @escaping () -> Void
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onBack = onBack
        self.onBranchTap = onBranchTap
        self.onInterestRateTap = onInterestRateTap
        self.onExchangeRateTap = onExchangeRateTap
        self.onExchangeTap = onExchangeTap
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            header

            VStack(spacing: 12) {
                ForEach(viewModel.features) { item in
                    Button {
                        if item.title == "Şube" {
                            onBranchTap()
                        } else if item.title == "Faiz Oranı" {
                            onInterestRateTap()
                        } else if item.title == "Döviz Kuru" {
                            onExchangeRateTap()
                        } else if item.title == "Döviz Çevirici" {
                            onExchangeTap()
                        }
                    } label: {
                        featureRow(item)
                    }
                    .buttonStyle(.plain)
                }
            }

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 14)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(AppTheme.background)
    }

    private var header: some View {
        HStack(spacing: 12) {
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.black.opacity(0.84))
            }
            .buttonStyle(.plain)
            Text("Arama")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .foregroundStyle(.black.opacity(0.84))
            Spacer()
        }
    }

    private func featureRow(_ item: SearchFeatureItem) -> some View {
        HStack(spacing: 14) {
            VStack(alignment: .leading, spacing: 6) {
                Text(item.title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.black.opacity(0.82))
                Text(item.subtitle)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.black.opacity(0.45))
            }

            Spacer()

            ZStack {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .fill(Color.white)
                    .frame(width: 64, height: 64)

                Image(systemName: item.imageName)
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundStyle(AppTheme.authPrimary)
            }
        }
        .padding(14)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.black.opacity(0.04), lineWidth: 1)
        }
    }
}

#Preview {
    SearchHubView(
        viewModel: SearchViewModel(),
        onBack: {},
        onBranchTap: {},
        onInterestRateTap: {},
        onExchangeRateTap: {},
        onExchangeTap: {}
    )
}
