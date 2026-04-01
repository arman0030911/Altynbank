import SwiftUI

struct WithdrawView: View {
    @StateObject private var viewModel: WithdrawViewModel
    let onBack: () -> Void

    init(viewModel: WithdrawViewModel, onBack: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onBack = onBack
    }

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                topBar

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 14) {
                        illustration
                        accountField
                        phoneField
                        amountSection
                        verifyButton
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 10)
                    .padding(.bottom, 24)
                }
            }
            .background(Color.white)

            if viewModel.showAccountPicker {
                Color.black.opacity(0.25)
                    .ignoresSafeArea()
                    .onTapGesture { viewModel.showAccountPicker = false }

                accountPicker
                    .padding(.horizontal, 18)
            }
        }
    }

    private var topBar: some View {
        HStack(spacing: 12) {
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.black.opacity(0.82))
            }
            .buttonStyle(.plain)

            Text("Para Çek")
                .font(.system(size: 34, weight: .bold, design: .rounded))
                .foregroundStyle(.black.opacity(0.82))

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .padding(.bottom, 8)
    }

    private var illustration: some View {
        ZStack {
            Ellipse()
                .fill(Color(red: 0.95, green: 0.94, blue: 0.98))
                .frame(height: 56)
                .offset(y: 32)

            HStack(spacing: 20) {
                Image(systemName: "wallet.pass.fill")
                    .font(.system(size: 48))
                    .foregroundStyle(AppTheme.authPrimary)

                Image(systemName: "arrow.left.arrow.right")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(.black.opacity(0.3))

                Image(systemName: "iphone.gen3.radiowaves.left.and.right")
                    .font(.system(size: 48))
                    .foregroundStyle(Color(red: 0.65, green: 0.54, blue: 0.22))
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 4)
    }

    private var accountField: some View {
        Button {
            viewModel.showAccountPicker = true
        } label: {
            HStack {
                Text(viewModel.selectedAccountLabel.isEmpty ? "Hesap / kart seç" : viewModel.selectedAccountLabel)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(viewModel.selectedAccountLabel.isEmpty ? .black.opacity(0.33) : .black.opacity(0.75))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)

                Spacer()

                Image(systemName: "chevron.down")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.black.opacity(0.35))
            }
            .padding(.horizontal, 12)
            .frame(height: 44)
            .overlay {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(Color.black.opacity(0.16), lineWidth: 1)
            }
        }
        .buttonStyle(.plain)
    }

    private var phoneField: some View {
        TextField("Telefon numarası", text: $viewModel.phoneNumber)
            .keyboardType(.phonePad)
            .font(.system(size: 15, weight: .medium))
            .textInputAutocapitalization(.never)
            .padding(.horizontal, 12)
            .frame(height: 44)
            .overlay {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(Color.black.opacity(0.16), lineWidth: 1)
            }
    }

    private var amountSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Tutar seç")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.black.opacity(0.36))

            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 3), spacing: 10) {
                ForEach(viewModel.amountOptions, id: \.self) { amount in
                    amountButton(title: "₺\(amount)", isSelected: viewModel.selectedAmount == amount) {
                        viewModel.selectAmount(amount)
                    }
                }

                amountButton(title: "Diğer", isSelected: viewModel.isOtherSelected) {
                    viewModel.selectOtherAmount()
                }
            }

            if viewModel.isOtherSelected {
                TextField("Tutar gir", text: $viewModel.customAmount)
                    .keyboardType(.numberPad)
                    .font(.system(size: 15, weight: .medium))
                    .padding(.horizontal, 12)
                    .frame(height: 42)
                    .overlay {
                        RoundedRectangle(cornerRadius: 11, style: .continuous)
                            .stroke(Color.black.opacity(0.16), lineWidth: 1)
                    }
            }
        }
    }

    private var verifyButton: some View {
        Button("Doğrula") {}
            .buttonStyle(.plain)
            .font(.system(size: 26, weight: .semibold, design: .rounded))
            .foregroundStyle(.white.opacity(viewModel.isVerifyEnabled ? 1 : 0.65))
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(viewModel.isVerifyEnabled ? AppTheme.authPrimary : AppTheme.authDisabled)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .disabled(!viewModel.isVerifyEnabled)
            .padding(.top, 2)
    }

    private func amountButton(title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundStyle(isSelected ? .white : .black.opacity(0.54))
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(isSelected ? AppTheme.authPrimary : Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .overlay {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(Color.black.opacity(0.06), lineWidth: 1)
                }
        }
        .buttonStyle(.plain)
    }

    private var accountPicker: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Spacer()
                Text("Hesap seç")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.black.opacity(0.8))
                Spacer()
                Button {
                    viewModel.showAccountPicker = false
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(.black.opacity(0.45))
                }
                .buttonStyle(.plain)
            }

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(viewModel.accounts) { account in
                        Button {
                            viewModel.selectedAccountLabel = account.label
                            viewModel.showAccountPicker = false
                        } label: {
                            HStack {
                                Text(account.label)
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundStyle(.black.opacity(0.72))
                                    .lineLimit(1)

                                Spacer()

                                if viewModel.selectedAccountLabel == account.label {
                                    Image(systemName: "checkmark")
                                        .font(.system(size: 13, weight: .bold))
                                        .foregroundStyle(AppTheme.authPrimary)
                                }
                            }
                            .padding(.vertical, 12)
                        }
                        .buttonStyle(.plain)

                        Divider()
                    }
                }
            }
            .frame(maxHeight: 260)
        }
        .padding(14)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
    }
}

#Preview {
    WithdrawView(
        viewModel: WithdrawViewModel(cards: HomeViewModel(user: nil).cards),
        onBack: {}
    )
}
