import SwiftUI

struct AuthField<Content: View>: View {
    let placeholder: String
    let leadingIcon: String
    let trailingIcon: String?
    @ViewBuilder let content: Content

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: leadingIcon)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(AppTheme.authPrimary.opacity(0.45))

            content
                .font(.system(size: 15, weight: .medium))
                .foregroundStyle(.black.opacity(0.82))

            Spacer(minLength: 0)

            if let trailingIcon {
                Image(systemName: trailingIcon)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(Color.black.opacity(0.2))
            }
        }
        .padding(.horizontal, 14)
        .frame(height: 48)
        .background(.white)
        .overlay {
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .stroke(AppTheme.authFieldBorder, lineWidth: 1)
        }
    }
}

struct AuthArtwork: View {
    let symbol: String
    let symbolSize: CGFloat

    var body: some View {
        ZStack {
            Circle()
                .fill(AppTheme.authPrimaryLight)
                .frame(width: 112, height: 112)

            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(AppTheme.authPrimary)
                .frame(width: 44, height: 62)
                .overlay {
                    Image(systemName: symbol)
                        .font(.system(size: symbolSize, weight: .semibold))
                        .foregroundStyle(.white)
                }

            Circle()
                .fill(AppTheme.authPrimary)
                .frame(width: 8, height: 8)
                .offset(x: 4, y: -63)

            Circle()
                .fill(Color(red: 0.80, green: 0.37, blue: 0.36))
                .frame(width: 19, height: 19)
                .offset(x: 66, y: -40)

            Circle()
                .fill(Color(red: 0.93, green: 0.74, blue: 0.23))
                .frame(width: 16, height: 16)
                .offset(x: -44, y: 35)

            Circle()
                .fill(Color(red: 0.39, green: 0.74, blue: 0.65))
                .frame(width: 8, height: 8)
                .offset(x: -78, y: -12)

            Circle()
                .fill(Color(red: 0.42, green: 0.49, blue: 0.95))
                .frame(width: 8, height: 8)
                .offset(x: 55, y: 34)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 150)
    }
}

struct SignInArtwork: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(AppTheme.authPrimaryLight)
                .frame(width: 112, height: 112)

            VStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(AppTheme.authPrimary, lineWidth: 2.2)
                    .frame(width: 38, height: 34)
                    .overlay(alignment: .center) {
                        Image(systemName: "keyhole")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundStyle(AppTheme.authPrimary)
                    }
                    .overlay(alignment: .top) {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .trim(from: 0.08, to: 0.92)
                            .stroke(AppTheme.authPrimary, lineWidth: 2.2)
                            .frame(width: 22, height: 18)
                            .offset(y: -12)
                    }
            }

            Circle()
                .fill(AppTheme.authPrimary)
                .frame(width: 8, height: 8)
                .offset(x: 4, y: -63)

            Circle()
                .fill(Color(red: 0.80, green: 0.37, blue: 0.36))
                .frame(width: 19, height: 19)
                .offset(x: 66, y: -40)

            Circle()
                .fill(Color(red: 0.93, green: 0.74, blue: 0.23))
                .frame(width: 16, height: 16)
                .offset(x: -44, y: 35)

            Circle()
                .fill(Color(red: 0.39, green: 0.74, blue: 0.65))
                .frame(width: 8, height: 8)
                .offset(x: -78, y: -12)

            Circle()
                .fill(Color(red: 0.42, green: 0.49, blue: 0.95))
                .frame(width: 8, height: 8)
                .offset(x: 55, y: 34)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 150)
    }
}
