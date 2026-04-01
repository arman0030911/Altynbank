import SwiftUI

struct ExchangeView: View {
    @StateObject private var viewModel: ExchangeViewModel
    let onBack: () -> Void

    init(viewModel: ExchangeViewModel, onBack: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onBack = onBack
    }

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                topBar
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 14) {
                        heroArtwork
                        formCard
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 24)
                }
            }

            if viewModel.showCurrencyPicker {
                Color.black.opacity(0.28)
                    .ignoresSafeArea()
                    .onTapGesture { viewModel.showCurrencyPicker = false }

                currencyPicker
                    .padding(.horizontal, 16)
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

            Text("Döviz çevir")
                .font(.system(size: 34, weight: .bold, design: .rounded))
                .foregroundStyle(.black.opacity(0.84))

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .padding(.bottom, 6)
    }

    private var heroArtwork: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color(red: 0.97, green: 0.96, blue: 1.0))
                .frame(height: 180)

            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(AppTheme.authPrimary, lineWidth: 5)
                .frame(width: 90, height: 132)

            Image(systemName: "dollarsign.circle.fill")
                .font(.system(size: 32))
                .foregroundStyle(Color(red: 0.85, green: 0.72, blue: 0.25))
                .offset(x: 0, y: -10)

            HStack(spacing: 36) {
                Image(systemName: "person.fill")
                    .font(.system(size: 34))
                    .foregroundStyle(Color(red: 0.32, green: 0.26, blue: 0.72))
                Image(systemName: "person.fill")
                    .font(.system(size: 34))
                    .foregroundStyle(Color(red: 0.62, green: 0.33, blue: 0.34))
            }
            .offset(y: 30)
        }
        .padding(.horizontal, 16)
    }

    private var formCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Gönderen")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.black.opacity(0.38))

            amountRow(
                amount: $viewModel.fromAmount,
                currency: viewModel.fromCurrency.code,
                onCurrencyTap: { viewModel.openFromPicker() }
            )

            HStack(spacing: 14) {
                Image(systemName: "arrow.down")
                    .font(.system(size: 30, weight: .medium))
                    .foregroundStyle(AppTheme.authPrimary)
                Image(systemName: "arrow.up")
                    .font(.system(size: 30, weight: .medium))
                    .foregroundStyle(Color(red: 0.82, green: 0.47, blue: 0.45))
            }
            .frame(maxWidth: .infinity)

            Text("Alan")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.black.opacity(0.38))

            amountRow(
                amount: $viewModel.toAmount,
                currency: viewModel.toCurrency.code,
                onCurrencyTap: { viewModel.openToPicker() }
            )

            if viewModel.canExchange {
                HStack {
                    Text("Döviz kuru")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(AppTheme.authPrimary)
                    Spacer()
                    Text(viewModel.rateText)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(.black.opacity(0.65))
                }
            }

            Button("Çevir") {}
                .buttonStyle(.plain)
                .font(.system(size: 28, weight: .semibold, design: .rounded))
                .foregroundStyle(.white.opacity(viewModel.canExchange ? 1 : 0.65))
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(viewModel.canExchange ? AppTheme.authPrimary : AppTheme.authDisabled)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                .disabled(!viewModel.canExchange)
                .padding(.top, 4)
        }
        .padding(14)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(Color.black.opacity(0.04), lineWidth: 1)
        }
        .padding(.horizontal, 16)
    }

    private func amountRow(amount: Binding<String>, currency: String, onCurrencyTap: @escaping () -> Void) -> some View {
        HStack(spacing: 8) {
            TextField("Tutar", text: amount)
                .keyboardType(.decimalPad)
                .font(.system(size: 26, weight: .semibold))
                .foregroundStyle(.black.opacity(0.82))
            Divider()
            Button(action: onCurrencyTap) {
                HStack(spacing: 6) {
                    Text(currency)
                        .font(.system(size: 26, weight: .semibold))
                        .foregroundStyle(.black.opacity(0.62))
                    Image(systemName: "chevron.down")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.black.opacity(0.38))
                }
            }
            .buttonStyle(.plain)
        }
        .frame(height: 64)
        .padding(.horizontal, 12)
        .overlay {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(Color.black.opacity(0.17), lineWidth: 1)
        }
    }

    private var currencyPicker: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Spacer()
                Text("Para birimini seç")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.black.opacity(0.78))
                Spacer()
                Button(action: { viewModel.showCurrencyPicker = false }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.black.opacity(0.45))
                }
                .buttonStyle(.plain)
            }

            ForEach(viewModel.currencyOptions) { option in
                Button {
                    viewModel.selectCurrency(option)
                } label: {
                    HStack {
                        Text("\(option.code) ( \(option.title) )")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundStyle(option.code == currentPicked.code ? AppTheme.authPrimary : .black.opacity(0.45))
                        Spacer()
                        if option.code == currentPicked.code {
                            Image(systemName: "checkmark")
                                .font(.system(size: 13, weight: .bold))
                                .foregroundStyle(AppTheme.authPrimary)
                        }
                    }
                    .padding(.vertical, 4)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(18)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }

    private var currentPicked: CurrencyOption {
        viewModel.pickingFromCurrency ? viewModel.fromCurrency : viewModel.toCurrency
    }
}

#Preview {
    ExchangeView(viewModel: ExchangeViewModel(), onBack: {})
}
