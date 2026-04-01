import SwiftUI

struct SettingsChangePasswordView: View {
    let onBack: () -> Void

    @State private var currentPassword = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""

    var body: some View {
        VStack(spacing: 0) {
            topBar

            VStack(spacing: 12) {
                inputField(title: "Mevcut şifre", placeholder: "Mevcut şifre", text: $currentPassword)
                inputField(title: "Yeni şifre", placeholder: "Yeni şifre", text: $newPassword)
                inputField(title: "Yeni şifre (tekrar)", placeholder: "Yeni şifreyi doğrula", text: $confirmPassword)

                Button("Şifreyi Güncelle") {}
                    .buttonStyle(.plain)
                    .font(.system(size: 24, weight: .semibold, design: .rounded))
                    .foregroundStyle(.white.opacity(isValid ? 1 : 0.65))
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(isValid ? AppTheme.authPrimary : AppTheme.authDisabled)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .disabled(!isValid)
                    .padding(.top, 8)
            }
            .padding(14)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .padding(.horizontal, 16)
            .padding(.top, 12)

            Spacer()
        }
        .background(AppTheme.background)
    }

    private var topBar: some View {
        HStack(spacing: 12) {
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.black.opacity(0.8))
            }
            .buttonStyle(.plain)

            Text("Şifre Değiştir")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .foregroundStyle(.black.opacity(0.85))

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .padding(.bottom, 12)
        .background(Color.white)
    }

    private func inputField(title: String, placeholder: String, text: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(.black.opacity(0.45))

            SecureField(placeholder, text: text)
                .font(.system(size: 16, weight: .medium))
                .padding(.horizontal, 12)
                .frame(height: 42)
                .overlay {
                    RoundedRectangle(cornerRadius: 11, style: .continuous)
                        .stroke(Color.black.opacity(0.16), lineWidth: 1)
                }
        }
    }

    private var isValid: Bool {
        let current = currentPassword.trimmingCharacters(in: .whitespacesAndNewlines)
        let new = newPassword.trimmingCharacters(in: .whitespacesAndNewlines)
        let confirm = confirmPassword.trimmingCharacters(in: .whitespacesAndNewlines)
        return !current.isEmpty && !new.isEmpty && new.count >= 6 && new == confirm
    }
}

#Preview {
    SettingsChangePasswordView(onBack: {})
}

