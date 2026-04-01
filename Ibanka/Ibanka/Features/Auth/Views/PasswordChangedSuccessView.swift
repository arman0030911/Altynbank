import SwiftUI

struct PasswordChangedSuccessView: View {
    let onOk: () -> Void

    var body: some View {
        ZStack(alignment: .top) {
            Color.white.ignoresSafeArea()

            VStack(spacing: 0) {
                HStack {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.black.opacity(0.8))
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 18)
                .padding(.bottom, 14)

                Spacer().frame(height: 22)

                SuccessArtwork()
                    .frame(height: 190)

                Text("Şifre başarıyla değiştirildi!")
                    .font(.system(size: 34, weight: .bold, design: .rounded))
                    .foregroundStyle(AppTheme.authPrimary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 34)
                    .padding(.top, 18)

                Text("Şifren başarıyla değiştirildi.\nLütfen giriş yaparken yeni şifreni kullan.")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.black.opacity(0.72))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 34)
                    .padding(.top, 14)

                Button("Tamam") {
                    onOk()
                }
                .buttonStyle(.plain)
                .font(.system(size: 22, weight: .semibold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 54)
                .background(AppTheme.authPrimary)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                .padding(.horizontal, 20)
                .padding(.top, 28)

                Spacer()
            }
        }
    }
}

private struct SuccessArtwork: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(AppTheme.authPrimary, lineWidth: 3)
                .frame(width: 110, height: 150)
                .overlay(alignment: .top) {
                    RoundedRectangle(cornerRadius: 3, style: .continuous)
                        .fill(AppTheme.authPrimary)
                        .frame(width: 26, height: 6)
                        .offset(y: 4)
                }

            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 34))
                .foregroundStyle(AppTheme.authPrimary)
                .offset(x: -20, y: -5)

            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(AppTheme.authPrimary)
                .frame(width: 62, height: 86)
                .overlay {
                    Image(systemName: "shield.fill")
                        .font(.system(size: 30))
                        .foregroundStyle(.white)
                }
                .rotationEffect(.degrees(16))
                .offset(x: 48, y: 24)

            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color(red: 0.95, green: 0.76, blue: 0.27))
                .frame(width: 42, height: 32)
                .overlay {
                    Image(systemName: "key.fill")
                        .font(.system(size: 15))
                        .foregroundStyle(.white)
                }
                .offset(x: 92, y: 54)

            RoundedRectangle(cornerRadius: 40, style: .continuous)
                .fill(Color(red: 0.74, green: 0.88, blue: 0.76))
                .frame(width: 72, height: 86)
                .offset(x: -96, y: 32)

            RoundedRectangle(cornerRadius: 40, style: .continuous)
                .fill(Color(red: 0.63, green: 0.82, blue: 0.70))
                .frame(width: 78, height: 92)
                .offset(x: 102, y: 32)
        }
    }
}

#Preview {
    PasswordChangedSuccessView(onOk: {})
}
