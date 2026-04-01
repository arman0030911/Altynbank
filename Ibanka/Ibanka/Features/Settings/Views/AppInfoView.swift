import SwiftUI

struct AppInfoView: View {
    let onBack: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            topBar

            VStack(alignment: .leading, spacing: 0) {
                Text("iBanka Mobil Bankacılık")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundStyle(.black.opacity(0.85))
                    .padding(.top, 12)
                    .padding(.bottom, 16)

                infoRow("Yayın Tarihi", value: "Nis 2026")
                infoRow("Sürüm", value: "1.0.0")
                infoRow("Dil", value: "Türkçe")

                Spacer()
            }
            .padding(.horizontal, 16)
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

            Text("Uygulama Bilgileri")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .foregroundStyle(.black.opacity(0.85))

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .padding(.bottom, 12)
        .background(Color.white)
    }

    private func infoRow(_ title: String, value: String) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.black.opacity(0.75))

            Spacer()

            Text(value)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(AppTheme.authPrimary)
        }
        .frame(height: 56)
        .overlay(alignment: .bottom) {
            Divider()
        }
    }
}

#Preview {
    AppInfoView(onBack: {})
}

