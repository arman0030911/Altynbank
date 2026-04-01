import SwiftUI

struct BranchSearchView: View {
    @StateObject private var viewModel: BranchSearchViewModel
    let onBack: () -> Void

    init(viewModel: BranchSearchViewModel, onBack: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onBack = onBack
    }

    var body: some View {
        VStack(spacing: 0) {
            topBar
            mapPlaceholder
            resultsCard
            Spacer(minLength: 0)
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

            Text("Şube")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .foregroundStyle(.black.opacity(0.85))

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .padding(.bottom, 10)
        .background(Color.white)
    }

    private var mapPlaceholder: some View {
        ZStack {
            Rectangle()
                .fill(
                    LinearGradient(
                        colors: [Color(white: 0.94), Color(white: 0.86)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(height: 220)

            ForEach(0..<5) { idx in
                Image(systemName: "mappin.circle.fill")
                    .font(.system(size: idx == 2 ? 30 : 20))
                    .foregroundStyle(AppTheme.authPrimary)
                    .offset(
                        x: [ -120, 40, -20, 95, 130 ][idx],
                        y: [ -52, -14, 24, 48, -30 ][idx]
                    )
            }
        }
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(Color.black.opacity(0.08))
                .frame(height: 1)
        }
    }

    private var resultsCard: some View {
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.black.opacity(0.45))
                TextField("Banka ara", text: $viewModel.query)
                    .textInputAutocapitalization(.never)
                Image(systemName: "xmark")
                    .foregroundStyle(.black.opacity(0.26))
            }
            .padding(.horizontal, 14)
            .frame(height: 42)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(Color.black.opacity(0.08), lineWidth: 1)
            }

            ForEach(viewModel.branches) { item in
                HStack(spacing: 10) {
                    Image(systemName: "mappin.circle.fill")
                        .font(.system(size: 16))
                        .foregroundStyle(AppTheme.authPrimary)
                    Text(item.name)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundStyle(.black.opacity(0.76))
                    Spacer()
                    Text(item.distance)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.black.opacity(0.38))
                }
                .padding(.vertical, 6)
            }
        }
        .padding(14)
        .background(Color.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
        )
        .padding(.horizontal, 12)
        .padding(.top, -22)
    }
}

#Preview {
    BranchSearchView(viewModel: BranchSearchViewModel(), onBack: {})
}
