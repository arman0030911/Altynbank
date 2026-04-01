import SwiftUI

struct MessageThreadView: View {
    let thread: MessageThread
    let onBack: () -> Void

    @State private var draft = ""
    @State private var messages: [BankThreadMessage]

    init(thread: MessageThread, onBack: @escaping () -> Void) {
        self.thread = thread
        self.onBack = onBack
        _messages = State(initialValue: thread.messages)
    }

    var body: some View {
        VStack(spacing: 0) {
            topBar

            ScrollView(showsIndicators: false) {
                VStack(spacing: 10) {
                    ForEach(messages) { message in
                        HStack {
                            if message.isIncoming {
                                Text(message.text)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 10)
                                    .background(Color(red: 0.94, green: 0.93, blue: 0.97))
                                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                                    .foregroundStyle(.black.opacity(0.82))
                                    .frame(maxWidth: 260, alignment: .leading)
                                Spacer()
                            } else {
                                Spacer()
                                Text(message.text)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 10)
                                    .background(AppTheme.authPrimary)
                                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: 220, alignment: .trailing)
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 12)
                .padding(.bottom, 18)
            }

            inputBar
                .padding(.horizontal, 16)
                .padding(.top, 8)
                .padding(.bottom, 12)
                .background(Color.white)
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

            Text(thread.bankName)
                .font(.system(size: 29, weight: .bold, design: .rounded))
                .foregroundStyle(.black.opacity(0.85))

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .padding(.bottom, 10)
        .background(Color.white)
    }

    private var inputBar: some View {
        HStack(spacing: 10) {
            TextField("Mesaj yaz...", text: $draft)
                .textInputAutocapitalization(.sentences)
                .padding(.horizontal, 12)
                .frame(height: 40)
                .overlay {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .stroke(Color.black.opacity(0.15), lineWidth: 1)
                }

            Button {
                sendMessage()
            } label: {
                Image(systemName: "arrow.right")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white)
                    .frame(width: 40, height: 40)
                    .background(AppTheme.authPrimary)
                    .clipShape(Circle())
            }
            .buttonStyle(.plain)
            .disabled(draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            .opacity(draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.55 : 1)
        }
    }

    private func sendMessage() {
        let cleanDraft = draft.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !cleanDraft.isEmpty else { return }

        messages.append(
            BankThreadMessage(
                text: cleanDraft,
                isIncoming: false,
                dateText: "Bugün"
            )
        )

        draft = ""
    }
}

#Preview {
    MessageThreadView(
        thread: MessagesViewModel().threads.first!,
        onBack: {}
    )
}

