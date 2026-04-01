import SwiftUI

struct InterestRateView: View {
    @StateObject private var viewModel: InterestRateViewModel
    let onBack: () -> Void

    init(viewModel: InterestRateViewModel, onBack: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onBack = onBack
    }

    var body: some View {
        VStack(spacing: 0) {
            topBar

            headerRow
                .padding(.horizontal, 16)
                .padding(.top, 10)
                .padding(.bottom, 6)

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(viewModel.items) { item in
                        row(item)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                        Divider()
                            .padding(.leading, 16)
                    }
                }
                .padding(.bottom, 12)
            }
        }
        .background(Color.white)
    }

    private var topBar: some View {
        HStack(spacing: 12) {
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.black.opacity(0.8))
            }
            .buttonStyle(.plain)

            Text("Faiz Oranı")
                .font(.system(size: 34, weight: .bold, design: .rounded))
                .foregroundStyle(.black.opacity(0.84))

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .padding(.bottom, 10)
    }

    private var headerRow: some View {
        HStack {
            Text("Faiz Türü")
                .foregroundStyle(.black.opacity(0.35))
            Spacer()
            Text("Vade")
                .frame(width: 58, alignment: .leading)
                .foregroundStyle(.black.opacity(0.35))
            Text("Oran")
                .frame(width: 54, alignment: .trailing)
                .foregroundStyle(.black.opacity(0.35))
        }
        .font(.system(size: 15, weight: .semibold))
    }

    private func row(_ item: InterestRateItem) -> some View {
        HStack {
            Text(item.interestKind)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.black.opacity(0.8))
            Spacer()
            Text(item.deposit)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.black.opacity(0.72))
                .frame(width: 58, alignment: .leading)
            Text(item.rate)
                .font(.system(size: 17, weight: .bold))
                .foregroundStyle(AppTheme.authPrimary)
                .frame(width: 54, alignment: .trailing)
        }
    }
}

#Preview {
    InterestRateView(viewModel: InterestRateViewModel(), onBack: {})
}
