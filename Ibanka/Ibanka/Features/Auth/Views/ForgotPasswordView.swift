import SwiftUI

struct ForgotPasswordView: View {
    @StateObject private var viewModel: ForgotPasswordViewModel
    private let onSend: () -> Void
    private let onBack: () -> Void

    init(
        viewModel: ForgotPasswordViewModel,
        onSend: @escaping () -> Void,
        onBack: @escaping () -> Void
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onSend = onSend
        self.onBack = onBack
    }

    var body: some View {
        ZStack(alignment: .top) {
            Color.white.ignoresSafeArea()

            VStack(spacing: 0) {
                topBar
                content
            }
        }
    }

    private var topBar: some View {
        HStack(spacing: 12) {
            Button {
                onBack()
            } label: {
                Image(systemName: "chevron.left")
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(.black.opacity(0.8))
            }
            .buttonStyle(.plain)

            Text("Şifremi unuttum")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .foregroundStyle(.black.opacity(0.88))

            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 18)
        .padding(.bottom, 14)
    }

    private var content: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Telefon numaranı yaz")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.black.opacity(0.46))

                TextField("(+90)", text: $viewModel.phoneNumber)
                    .keyboardType(.phonePad)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .font(.system(size: 15, weight: .medium))
                    .padding(.horizontal, 14)
                    .frame(height: 48)
                    .background(.white)
                    .overlay {
                        RoundedRectangle(cornerRadius: 13, style: .continuous)
                            .stroke(AppTheme.authFieldBorder, lineWidth: 1)
                    }

                Text("Numaranı doğrulamak için sana kod göndereceğiz.")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.black.opacity(0.75))
                    .padding(.top, 6)

                Button("Gönder") {
                    onSend()
                }
                .buttonStyle(.plain)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(viewModel.isSendEnabled ? AppTheme.authPrimary : AppTheme.authDisabled)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                .disabled(!viewModel.isSendEnabled || viewModel.isLoading)
                .padding(.top, 8)
            }
            .padding(14)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: Color.black.opacity(0.03), radius: 10, y: 6)
            .padding(.horizontal, 20)
            .padding(.top, 10)

            Spacer()
        }
    }
}

#Preview {
    ForgotPasswordView(
        viewModel: ForgotPasswordViewModel(),
        onSend: {},
        onBack: {}
    )
}
