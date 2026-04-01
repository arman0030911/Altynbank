import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel: ProfileViewModel

    init(viewModel: ProfileViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                VStack(spacing: 12) {
                    Text(viewModel.initials)
                        .font(.title.bold())
                        .foregroundStyle(.white)
                        .frame(width: 76, height: 76)
                        .background(AppTheme.accent)
                        .clipShape(Circle())

                    Text(viewModel.displayName)
                        .font(.title3.bold())
                }

                ForEach(viewModel.rows) { row in
                    HStack {
                        Text(row.title)
                            .foregroundStyle(AppTheme.mutedText)

                        Spacer()

                        Text(row.value)
                    }
                    .padding()
                    .background(AppTheme.cardBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }

                Button {
                    Task {
                        await viewModel.signOut()
                    }
                } label: {
                    Text("Çıkış Yap")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundStyle(.red)
                        .background(AppTheme.cardBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .buttonStyle(.plain)

                Spacer()
            }
            .padding(24)
            .background(AppTheme.background)
            .navigationTitle("Profil")
        }
    }
}

#Preview {
    ProfileView(
        viewModel: ProfileViewModel(user: nil, signOutAction: {})
    )
}
