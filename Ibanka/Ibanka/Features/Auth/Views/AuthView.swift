import SwiftUI

private enum AuthRoute {
    case signIn
    case signUp
    case forgotPassword
    case changePassword
    case passwordChangedSuccess
}

struct AuthView: View {
    @StateObject private var viewModel: AuthViewModel
    @State private var route: AuthRoute = .signIn

    init(viewModel: AuthViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack(alignment: .top) {
            AppTheme.authPrimary
                .ignoresSafeArea()

            VStack(spacing: 0) {
                switch route {
                case .signIn:
                    topBar
                    contentCard
                case .signUp:
                    SignUpView(
                        viewModel: SignUpViewModel(),
                        onBack: {
                            route = .signIn
                        }
                    )
                case .forgotPassword:
                    ForgotPasswordView(
                        viewModel: ForgotPasswordViewModel(),
                        onSend: {
                            route = .changePassword
                        },
                        onBack: {
                            route = .signIn
                        }
                    )
                case .changePassword:
                    ChangePasswordView(
                        viewModel: ChangePasswordViewModel(),
                        onSubmit: {
                            route = .passwordChangedSuccess
                        },
                        onBack: {
                            route = .forgotPassword
                        }
                    )
                case .passwordChangedSuccess:
                    PasswordChangedSuccessView {
                        route = .signIn
                    }
                }
            }
        }
    }

    private var topBar: some View {
        HStack(spacing: 12) {
            Image(systemName: "chevron.left")
                .font(.system(size: 17, weight: .semibold))

            Text("Giriş yap")
                .font(.headline.weight(.semibold))

            Spacer()
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 20)
        .padding(.top, 18)
        .padding(.bottom, 14)
    }

    private var contentCard: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Tekrar hoş geldin")
                    .font(.system(size: 33, weight: .bold, design: .rounded))
                    .foregroundStyle(AppTheme.authPrimary)

                Text("Merhaba, devam etmek için giriş yap")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.black.opacity(0.72))
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Spacer().frame(height: 18)

            SignInArtwork()

            Spacer().frame(height: 28)

            VStack(spacing: 14) {
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

            HStack {
                Spacer()
                Button("Şifremi unuttum?") {
                    route = .forgotPassword
                }
                .buttonStyle(.plain)
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(Color.black.opacity(0.28))
            }
            .padding(.top, 10)

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.footnote)
                    .foregroundStyle(.red)
                    .padding(.top, 12)
            }

            Button {
                Task {
                    await viewModel.signIn()
                }
            } label: {
                HStack {
                    Spacer()
                    if viewModel.isLoading {
                        ProgressView()
                            .tint(.white)
                    } else {
                        Text("Giriş yap")
                            .font(.system(size: 18, weight: .semibold))
                    }
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

            Spacer().frame(height: 26)

            Image(systemName: "touchid")
                .font(.system(size: 54, weight: .regular))
                .foregroundStyle(AppTheme.authPrimary)

            Spacer()

            HStack(spacing: 6) {
                Text("Hesabın yok mu?")
                    .foregroundStyle(Color.black.opacity(0.62))

                Button("Kayıt ol") {
                    route = .signUp
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
        .clipShape(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
        )
    }
}

#Preview {
    AuthView(viewModel: AuthViewModel { _, _ in })
}
