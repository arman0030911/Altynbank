import SwiftUI

struct TransferView: View {
    @StateObject private var viewModel: TransferViewModel
    let onBack: () -> Void
    let onConfirm: (TransferDraft) -> Void

    init(
        viewModel: TransferViewModel,
        onBack: @escaping () -> Void,
        onConfirm: @escaping (TransferDraft) -> Void
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onBack = onBack
        self.onConfirm = onConfirm
    }

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                topBar

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 16) {
                        accountRow
                        transferTypeSection
                        beneficiarySection
                        formSection
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                    .padding(.bottom, 24)
                }
            }
            .background(Color.white)

            if viewModel.showBankPicker {
                Color.black.opacity(0.25)
                    .ignoresSafeArea()
                    .onTapGesture { viewModel.showBankPicker = false }

                bankPicker
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

            Text("Transfer")
                .font(.system(size: 34, weight: .bold, design: .rounded))
                .foregroundStyle(.black.opacity(0.82))

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .padding(.bottom, 8)
    }

    private var accountRow: some View {
        HStack(spacing: 10) {
            TextField("Hesap / kart seç", text: $viewModel.account)
                .font(.system(size: 16, weight: .medium))
                .textInputAutocapitalization(.never)
            Image(systemName: "chevron.down")
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(.black.opacity(0.42))
        }
        .padding(.horizontal, 12)
        .frame(height: 44)
        .overlay {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(Color.black.opacity(0.16), lineWidth: 1)
        }
    }

    private var transferTypeSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("İşlem türü seç")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.black.opacity(0.35))

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(viewModel.transferTypes) { type in
                        Button {
                            viewModel.selectedTransferTypeID = type.id
                        } label: {
                            VStack(alignment: .leading, spacing: 8) {
                                Image(systemName: type.icon)
                                    .font(.system(size: 20, weight: .semibold))
                                Text(type.title)
                                    .font(.system(size: 12, weight: .semibold))
                                    .multilineTextAlignment(.leading)
                            }
                            .foregroundStyle(.white)
                            .frame(width: 120, height: 88, alignment: .leading)
                            .padding(.horizontal, 10)
                            .background(
                                viewModel.selectedTransferTypeID == type.id
                                ? AppTheme.authPrimary
                                : Color.black.opacity(0.18)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }

    private var beneficiarySection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Alıcı seç")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(.black.opacity(0.35))
                Spacer()
                Text("Alıcı bul")
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(AppTheme.authPrimary)
            }

            HStack(spacing: 10) {
                Button {} label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(Color(red: 0.95, green: 0.95, blue: 0.98))
                        Image(systemName: "plus")
                            .font(.system(size: 26, weight: .regular))
                            .foregroundStyle(Color.black.opacity(0.25))
                    }
                    .frame(width: 78, height: 78)
                }
                .buttonStyle(.plain)

                ForEach(viewModel.beneficiaries) { beneficiary in
                    Button {
                        viewModel.selectedBeneficiaryID = beneficiary.id
                        viewModel.name = beneficiary.name
                    } label: {
                        VStack(spacing: 6) {
                            Image(systemName: beneficiary.avatarSymbol)
                                .font(.system(size: 34))
                                .foregroundStyle(AppTheme.authPrimary)
                            Text(beneficiary.name)
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundStyle(.black.opacity(0.75))
                        }
                        .frame(width: 78, height: 78)
                        .background(Color.white)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .stroke(
                                    viewModel.selectedBeneficiaryID == beneficiary.id
                                    ? AppTheme.authPrimary
                                    : Color.black.opacity(0.08),
                                    lineWidth: 1
                                )
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    private var formSection: some View {
        VStack(spacing: 10) {
            if viewModel.isAnotherBankTransferSelected {
                buttonField(
                    text: viewModel.selectedBank.isEmpty ? "Banka seç" : viewModel.selectedBank
                ) {
                    viewModel.showBankPicker = true
                }
                transferField("Şube seç", text: $viewModel.branch)
            }

            transferField("Ad Soyad", text: $viewModel.name)
            transferField("Kart numarası", text: $viewModel.cardNumber)
            transferField("Tutar", text: $viewModel.amount)
            transferField("Açıklama", text: $viewModel.content)

            Toggle(isOn: $viewModel.saveBeneficiary) {
                Text("Alıcıyı rehbere kaydet")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(.black.opacity(0.46))
            }
            .toggleStyle(.checkbox)
            .padding(.top, 2)

            Button("Onayla") {
                onConfirm(viewModel.makeDraft())
            }
                .buttonStyle(.plain)
                .font(.system(size: 26, weight: .semibold, design: .rounded))
                .foregroundStyle(.white.opacity(viewModel.isConfirmEnabled ? 1 : 0.65))
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(viewModel.isConfirmEnabled ? AppTheme.authPrimary : AppTheme.authDisabled)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                .disabled(!viewModel.isConfirmEnabled)
                .padding(.top, 4)
        }
        .padding(12)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(Color.black.opacity(0.05), lineWidth: 1)
        }
    }

    private var bankPicker: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Alıcı bankasını seç")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.black.opacity(0.8))
                .frame(maxWidth: .infinity, alignment: .center)

            HStack(spacing: 8) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.black.opacity(0.32))
                TextField("Ara", text: $viewModel.bankSearchQuery)
                    .textInputAutocapitalization(.never)
            }
            .padding(.horizontal, 10)
            .frame(height: 38)
            .overlay {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(Color.black.opacity(0.16), lineWidth: 1)
            }

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    ForEach(viewModel.filteredBanks, id: \.self) { bank in
                        Button {
                            viewModel.selectedBank = bank
                            viewModel.showBankPicker = false
                        } label: {
                            HStack {
                                Text(bank)
                                    .font(.system(size: 15, weight: .medium))
                                    .foregroundStyle(.black.opacity(0.7))
                                Spacer()
                                if viewModel.selectedBank == bank {
                                    Image(systemName: "checkmark")
                                        .font(.system(size: 13, weight: .bold))
                                        .foregroundStyle(AppTheme.authPrimary)
                                }
                            }
                            .padding(.vertical, 11)
                        }
                        .buttonStyle(.plain)

                        Divider()
                    }
                }
            }
            .frame(maxHeight: 280)
        }
        .padding(14)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
    }

    private func transferField(_ placeholder: String, text: Binding<String>) -> some View {
        TextField(placeholder, text: text)
            .font(.system(size: 15, weight: .medium))
            .textInputAutocapitalization(.never)
            .padding(.horizontal, 12)
            .frame(height: 42)
            .overlay {
                RoundedRectangle(cornerRadius: 11, style: .continuous)
                    .stroke(Color.black.opacity(0.16), lineWidth: 1)
            }
    }

    private func buttonField(text: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Text(text)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(.black.opacity(0.62))
                Spacer()
                Image(systemName: "chevron.down")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.black.opacity(0.35))
            }
            .padding(.horizontal, 12)
            .frame(height: 42)
            .overlay {
                RoundedRectangle(cornerRadius: 11, style: .continuous)
                    .stroke(Color.black.opacity(0.16), lineWidth: 1)
            }
        }
        .buttonStyle(.plain)
    }
}

private struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            HStack(spacing: 10) {
                ZStack {
                    RoundedRectangle(cornerRadius: 4, style: .continuous)
                        .stroke(Color.black.opacity(0.3), lineWidth: 1)
                        .frame(width: 20, height: 20)

                    if configuration.isOn {
                        Image(systemName: "checkmark")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundStyle(AppTheme.authPrimary)
                    }
                }
                configuration.label
            }
        }
        .buttonStyle(.plain)
    }
}

private extension ToggleStyle where Self == CheckboxToggleStyle {
    static var checkbox: CheckboxToggleStyle { CheckboxToggleStyle() }
}

#Preview {
    TransferView(viewModel: TransferViewModel(), onBack: {}, onConfirm: { _ in })
}
