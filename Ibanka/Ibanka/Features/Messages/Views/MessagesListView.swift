import SwiftUI

struct MessagesListView: View {
    @ObservedObject var viewModel: MessagesViewModel
    let onBack: () -> Void
    let onOpenThread: (MessageThread) -> Void

    var body: some View {
        VStack(spacing: 0) {
            topBar

            ScrollView(showsIndicators: false) {
                VStack(spacing: 10) {
                    ForEach(viewModel.threads) { thread in
                        Button {
                            onOpenThread(thread)
                        } label: {
                            row(thread)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 10)
                .padding(.bottom, 18)
            }
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

            Text("Mesajlar")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .foregroundStyle(.black.opacity(0.85))

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .padding(.bottom, 10)
        .background(Color.white)
    }

    private func row(_ thread: MessageThread) -> some View {
        HStack(spacing: 12) {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(hex: thread.colorHex))
                .frame(width: 34, height: 34)
                .overlay {
                    Image(systemName: "building.columns.fill")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(.white)
                }

            VStack(alignment: .leading, spacing: 4) {
                Text(thread.bankName)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.black.opacity(0.84))

                Text(thread.preview)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(.black.opacity(0.56))
                    .lineLimit(1)
            }

            Spacer()

            Text(thread.dateText)
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(.black.opacity(0.36))
        }
        .padding(12)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(Color.black.opacity(0.05), lineWidth: 1)
        }
    }
}

private extension Color {
    init(hex: String) {
        let string = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: string).scanHexInt64(&int)
        self.init(
            .sRGB,
            red: Double((int >> 16) & 0xFF) / 255,
            green: Double((int >> 8) & 0xFF) / 255,
            blue: Double(int & 0xFF) / 255,
            opacity: 1
        )
    }
}

#Preview {
    MessagesListView(
        viewModel: MessagesViewModel(),
        onBack: {},
        onOpenThread: { _ in }
    )
}

