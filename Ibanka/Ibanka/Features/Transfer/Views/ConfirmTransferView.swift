import SwiftUI

struct ConfirmTransferView: View {
    @StateObject private var viewModel: ConfirmTransferViewModel
    let onBack: () -> Void

    init(viewModel: ConfirmTransferViewModel, onBack: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onBack = onBack
    }

    var body: some View {
        VStack(spacing: 0) {
            topBar

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Transfer bilgilerini onayla")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(.black.opacity(0.4))

                    confirmField("Gönderen hesap", value: viewModel.draft.fromAccountMasked)
                    confirmField("Alıcı", value: viewModel.draft.toName)
                    confirmField("Alıcı bankası", value: viewModel.draft.beneficiaryBank)
                    confirmField("Kart numarası", value: viewModel.draft.cardNumber)
                    confirmField("İşlem ücreti", value: viewModel.draft.fee)
                    confirmField("Açıklama", value: viewModel.draft.note)
                    confirmField("Tutar", value: viewModel.draft.amount)

                    Text("İşlemi doğrulamak için OTP al")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundStyle(.black.opacity(0.4))
                        .padding(.top, 8)

                    HStack(spacing: 10) {
                        TextField("OTP kodu", text: $viewModel.otp)
                            .keyboardType(.numberPad)
                            .font(.system(size: 16, weight: .semibold))
                            .padding(.horizontal, 12)
                            .frame(height: 42)
                            .overlay {
                                RoundedRectangle(cornerRadius: 11, style: .continuous)
                                    .stroke(Color.black.opacity(0.16), lineWidth: 1)
                            }

                        Button("OTP Al") {}
                            .buttonStyle(.plain)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.white.opacity(viewModel.canRequestOTP ? 1 : 0.7))
                            .frame(width: 86, height: 42)
                            .background(viewModel.canRequestOTP ? AppTheme.authPrimary : AppTheme.authDisabled)
                            .clipShape(RoundedRectangle(cornerRadius: 11, style: .continuous))
                            .disabled(!viewModel.canRequestOTP)
                    }

                    if let error = viewModel.authErrorMessage {
                        Text(error)
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.red)
                    }

                    Button("Onayla") {
                        Task {
                            _ = await viewModel.confirmWithAuthentication()
                        }
                    }
                        .buttonStyle(.plain)
                        .font(.system(size: 28, weight: .semibold, design: .rounded))
                        .foregroundStyle(.white.opacity(viewModel.canConfirm ? 1 : 0.65))
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(viewModel.canConfirm ? AppTheme.authPrimary : AppTheme.authDisabled)
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                        .disabled(!viewModel.canConfirm || viewModel.isProcessing)
                        .padding(.top, 8)
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 24)
            }
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

            Text("Onay")
                .font(.system(size: 34, weight: .bold, design: .rounded))
                .foregroundStyle(.black.opacity(0.82))

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .padding(.bottom, 8)
    }

    private func confirmField(_ title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.black.opacity(0.42))
            HStack {
                Text(value)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.black.opacity(0.75))
                Spacer()
            }
            .padding(.horizontal, 12)
            .frame(height: 42)
            .overlay {
                RoundedRectangle(cornerRadius: 11, style: .continuous)
                    .stroke(Color.black.opacity(0.16), lineWidth: 1)
            }
        }
    }
}

#Preview {
    ConfirmTransferView(
        viewModel: ConfirmTransferViewModel(
            draft: TransferDraft(
                fromAccountMasked: "**** **** 6789",
                toName: "Ayşe Demir",
                beneficiaryBank: "Türkiye İş Bankası",
                cardNumber: "0123456789",
                fee: "₺10",
                note: "Kira ödemesi",
                amount: "₺1000"
            )
        ),
        onBack: {}
    )
}
