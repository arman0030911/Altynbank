import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel: ChatViewModel

    init(viewModel: ChatViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.messages) { message in
                            HStack {
                                if message.isFromUser {
                                    Spacer(minLength: 48)
                                }

                                Text(message.text)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 12)
                                    .foregroundStyle(message.isFromUser ? .white : .primary)
                                    .background(message.isFromUser ? AppTheme.accent : AppTheme.cardBackground)
                                    .clipShape(RoundedRectangle(cornerRadius: 18))

                                if !message.isFromUser {
                                    Spacer(minLength: 48)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 16)
                }

                HStack(spacing: 12) {
                    TextField("Mesaj yaz", text: $viewModel.draftMessage)
                        .padding()
                        .background(AppTheme.cardBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 16))

                    Button("Gönder") {
                        viewModel.sendMessage()
                    }
                    .buttonStyle(.plain)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                    .foregroundStyle(.white)
                    .background(AppTheme.accent)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 16)
            }
            .background(AppTheme.background)
            .navigationTitle("Sohbet")
        }
    }
}

#Preview {
    ChatView(viewModel: ChatViewModel())
}
