import SwiftUI

struct ChangePasswordView: View {
    @StateObject private var viewModel: ChangePasswordViewModel
    private let onSubmit: () -> Void
    private let onBack: () -> Void

    init(
        viewModel: ChangePasswordViewModel,
        onSubmit: @escaping () -> Void,
        onBack: @escaping () -> Void
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onSubmit = onSubmit
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

            Text("Şifreyi değiştir")
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
            VStack(alignment: .leading, spacing: 12) {
                Text("Yeni şifreni yaz")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.black.opacity(0.46))

                passwordField(text: $viewModel.newPassword)

                Text("Şifreyi doğrula")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.black.opacity(0.46))
                    .padding(.top, 4)

                passwordField(text: $viewModel.confirmPassword)

                Button("Şifreyi değiştir") {
                    onSubmit()
                }
                .buttonStyle(.plain)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(viewModel.isSubmitEnabled ? AppTheme.authPrimary : AppTheme.authDisabled)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                .disabled(!viewModel.isSubmitEnabled || viewModel.isLoading)
                .padding(.top, 14)
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

    private func passwordField(text: Binding<String>) -> some View {
        HStack(spacing: 10) {
            SecureField("", text: text, prompt: Text("************"))
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .font(.system(size: 15, weight: .medium))

            Image(systemName: "eye")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.black.opacity(0.35))
        }
        .padding(.horizontal, 14)
        .frame(height: 48)
        .background(.white)
        .overlay {
            RoundedRectangle(cornerRadius: 13, style: .continuous)
                .stroke(AppTheme.authFieldBorder, lineWidth: 1)
        }
    }
}

#Preview {
    ChangePasswordView(
        viewModel: ChangePasswordViewModel(),
        onSubmit: {},
        onBack: {}
    )
}
