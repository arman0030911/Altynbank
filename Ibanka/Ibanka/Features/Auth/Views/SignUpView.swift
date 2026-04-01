import SwiftUI

struct SignUpView: View {
    @StateObject private var viewModel: SignUpViewModel
    private let onBack: () -> Void

    init(viewModel: SignUpViewModel, onBack: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onBack = onBack
    }

    var body: some View {
        ZStack(alignment: .top) {
            AppTheme.authPrimary
                .ignoresSafeArea()

            VStack(spacing: 0) {
                topBar
                contentCard
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
                    .foregroundStyle(.white)
            }
            .buttonStyle(.plain)

            Text("Kayıt ol")
                .font(.headline.weight(.semibold))
                .foregroundStyle(.white)

            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 18)
        .padding(.bottom, 14)
    }

    private var contentCard: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Aramıza hoş geldin")
                    .font(.system(size: 31, weight: .bold, design: .rounded))
                    .foregroundStyle(AppTheme.authPrimary)

                Text("Merhaba, yeni hesap oluştur")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.black.opacity(0.72))
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Spacer().frame(height: 16)

            AuthArtwork(symbol: "person.crop.rectangle", symbolSize: 19)

            Spacer().frame(height: 24)

            VStack(spacing: 14) {
                AuthField(
                    placeholder: "Ad Soyad",
                    leadingIcon: "person",
                    trailingIcon: nil
                ) {
                    TextField("", text: $viewModel.fullName, prompt: Text("Ad Soyad"))
                        .textInputAutocapitalization(.words)
                        .autocorrectionDisabled()
                }

                AuthField(
                    placeholder: "E-posta",
                    leadingIcon: "envelope",
                    trailingIcon: nil
                ) {
                    TextField("", text: $viewModel.email, prompt: Text("E-posta"))
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                        .autocorrectionDisabled()
                }

                AuthField(
                    placeholder: "Şifre",
                    leadingIcon: "lock",
                    trailingIcon: "chevron.down"
                ) {
                    SecureField("", text: $viewModel.password, prompt: Text("Şifre"))
                }
            }

            Button {
                viewModel.hasAcceptedTerms.toggle()
            } label: {
                HStack(alignment: .top, spacing: 10) {
                    RoundedRectangle(cornerRadius: 4, style: .continuous)
                        .stroke(AppTheme.authFieldBorder, lineWidth: 1.3)
                        .frame(width: 18, height: 18)
                        .overlay {
                            if viewModel.hasAcceptedTerms {
                                Image(systemName: "checkmark")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundStyle(AppTheme.authPrimary)
                            }
                        }

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Hesap oluşturarak")
                            .foregroundStyle(Color.black.opacity(0.62))

                        Text("Koşullar ve Şartlar'ı kabul ediyorum")
                            .foregroundStyle(AppTheme.authPrimary)
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 13, weight: .semibold))

                    Spacer()
                }
                .padding(.top, 14)
            }
            .buttonStyle(.plain)

            Button {
            } label: {
                HStack {
                    Spacer()
                    Text("Kayıt ol")
                        .font(.system(size: 18, weight: .semibold))
                    Spacer()
                }
                .frame(height: 52)
            }
            .buttonStyle(.plain)
            .foregroundStyle(.white)
            .background(viewModel.isFormValid ? AppTheme.authPrimary : AppTheme.authDisabled)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .disabled(!viewModel.isFormValid || viewModel.isLoading)
            .padding(.top, 22)

            Spacer()

            HStack(spacing: 6) {
                Text("Zaten hesabın var mı?")
                    .foregroundStyle(Color.black.opacity(0.62))

                Button("Giriş yap") {
                    onBack()
                }
                .buttonStyle(.plain)
                .fontWeight(.bold)
                .foregroundStyle(AppTheme.authPrimary)
            }
            .font(.system(size: 13, weight: .semibold))
            .padding(.bottom, 10)
        }
        .padding(.horizontal, 20)
        .padding(.top, 18)
        .padding(.bottom, 22)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
    }
}

#Preview {
    SignUpView(viewModel: SignUpViewModel(), onBack: {})
}
