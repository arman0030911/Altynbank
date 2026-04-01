import SwiftUI

struct SettingsView: View {
    let userName: String
    let onBack: () -> Void
    let onPasswordTap: () -> Void
    let onAppInfoTap: () -> Void

    var body: some View {
        ZStack(alignment: .top) {
            AppTheme.authPrimary
                .ignoresSafeArea()

            VStack(spacing: 0) {
                topBar

                VStack(spacing: 0) {
                    avatarBlock
                    settingsRows
                    Spacer()
                }
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                .padding(.top, 10)
            }
        }
    }

    private var topBar: some View {
        HStack(spacing: 12) {
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(.white)
            }
            .buttonStyle(.plain)

            Text("Ayarlar")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .foregroundStyle(.white)

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .padding(.bottom, 14)
    }

    private var avatarBlock: some View {
        VStack(spacing: 8) {
            Circle()
                .fill(Color.black.opacity(0.18))
                .frame(width: 96, height: 96)
                .overlay {
                    Text(initials)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundStyle(.white)
                }

            Text(userName)
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundStyle(AppTheme.authPrimary)
        }
        .padding(.top, 18)
        .padding(.bottom, 16)
    }

    private var settingsRows: some View {
        VStack(spacing: 0) {
            settingsRow("Şifre", value: nil, action: onPasswordTap)
            settingsRow("Biyometrik Giriş", value: nil, action: {})
            settingsRow("Dil", value: "Türkçe", action: {})
            settingsRow("Uygulama Bilgileri", value: nil, action: onAppInfoTap)
            settingsRow("Müşteri Hizmetleri", value: "0850 222 00 00", action: {})
        }
    }

    private func settingsRow(_ title: String, value: String?, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.system(size: 21, weight: .semibold))
                    .foregroundStyle(.black.opacity(0.8))

                Spacer()

                if let value {
                    Text(value)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(.black.opacity(0.45))
                } else {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundStyle(.black.opacity(0.25))
                }
            }
            .padding(.horizontal, 16)
            .frame(height: 56)
            .overlay(alignment: .bottom) {
                Divider().padding(.leading, 16)
            }
        }
        .buttonStyle(.plain)
    }

    private var initials: String {
        let parts = userName.split(separator: " ")
        let letters = parts.prefix(2).compactMap(\.first)
        return String(letters)
    }
}

#Preview {
    SettingsView(
        userName: "Ahmet Yılmaz",
        onBack: {},
        onPasswordTap: {},
        onAppInfoTap: {}
    )
}

