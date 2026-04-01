import SwiftUI

struct ExchangeRateView: View {
    @StateObject private var viewModel: ExchangeRateViewModel
    let onBack: () -> Void

    init(viewModel: ExchangeRateViewModel, onBack: @escaping () -> Void) {
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

            Text("Döviz kuru")
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
            Text("Ülke")
                .foregroundStyle(.black.opacity(0.35))
            Spacer()
            Text("Alış")
                .frame(width: 58, alignment: .trailing)
                .foregroundStyle(.black.opacity(0.35))
            Text("Satış")
                .frame(width: 62, alignment: .trailing)
                .foregroundStyle(.black.opacity(0.35))
        }
        .font(.system(size: 15, weight: .semibold))
    }

    private func row(_ item: ExchangeRateItem) -> some View {
        HStack(spacing: 10) {
            Text(item.flag)
                .font(.system(size: 22))
                .frame(width: 34, alignment: .leading)
            Text(item.country)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.black.opacity(0.82))
            Spacer()
            Text(item.buy)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.black.opacity(0.72))
                .frame(width: 58, alignment: .trailing)
            Text(item.sell)
                .font(.system(size: 16, weight: .semibold))
                .foregroundStyle(.black.opacity(0.72))
                .frame(width: 62, alignment: .trailing)
        }
    }
}

#Preview {
    ExchangeRateView(viewModel: ExchangeRateViewModel(), onBack: {})
}
