import SwiftUI

struct ReportView: View {
    let onBack: () -> Void

    private let monthlyValues: [Double] = [620, 700, 920, 660, 560, 740]

    var body: some View {
        ZStack(alignment: .top) {
            AppTheme.authPrimary
                .ignoresSafeArea()

            VStack(spacing: 0) {
                topBar

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 14) {
                        cardHeader
                        chartCard
                        activityCard
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                    .padding(.bottom, 24)
                }
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))
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

            Text("İşlem Raporu")
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .foregroundStyle(.white)

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .padding(.bottom, 12)
    }

    private var cardHeader: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.20, green: 0.14, blue: 0.53),
                            Color(red: 0.36, green: 0.30, blue: 0.88)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            VStack(alignment: .leading, spacing: 8) {
                Text("Ahmet Yılmaz")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)

                Text("Vadesiz Hesap")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(.white.opacity(0.78))

                Text("4756   ••••   ••••   9018")
                    .font(.system(size: 15, weight: .semibold, design: .monospaced))
                    .foregroundStyle(.white.opacity(0.9))

                HStack {
                    Text("₺3.469,52")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(.white)
                    Spacer()
                    Text("VISA")
                        .font(.system(size: 24, weight: .black, design: .rounded))
                        .foregroundStyle(.white)
                }
            }
            .padding(20)
        }
        .frame(height: 170)
    }

    private var chartCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Bakiye")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.black.opacity(0.48))

            Text("₺1000")
                .font(.system(size: 44, weight: .bold, design: .rounded))
                .foregroundStyle(AppTheme.authPrimary)

            HStack(alignment: .bottom, spacing: 14) {
                ForEach(Array(monthlyValues.enumerated()), id: \.offset) { _, value in
                    RoundedRectangle(cornerRadius: 3, style: .continuous)
                        .fill(AppTheme.authPrimary)
                        .frame(width: 12, height: value / 4)
                }
            }
            .frame(maxWidth: .infinity, minHeight: 110, alignment: .bottom)

            Text("Oca    Şub    Mar    Nis    May    Haz")
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(.black.opacity(0.35))
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(14)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .stroke(Color.black.opacity(0.05), lineWidth: 1)
        }
    }

    private var activityCard: some View {
        VStack(spacing: 0) {
            transactionRow(title: "Su Faturası", subtitle: "Başarısız", amount: "-₺280", isExpense: true)
            Divider().padding(.leading, 10)
            transactionRow(title: "Maaş Ödemesi", subtitle: "Tamamlandı", amount: "+₺28.500", isExpense: false)
        }
        .padding(10)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.black.opacity(0.05), lineWidth: 1)
        }
    }

    private func transactionRow(title: String, subtitle: String, amount: String, isExpense: Bool) -> some View {
        HStack(spacing: 10) {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(isExpense ? AppTheme.authPrimary : Color(red: 0.81, green: 0.43, blue: 0.43))
                .frame(width: 28, height: 28)
                .overlay {
                    Image(systemName: isExpense ? "drop.fill" : "turkishlirasign")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(.white)
                }

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(.black.opacity(0.82))
                Text(subtitle)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.black.opacity(0.45))
            }

            Spacer()

            Text(amount)
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(isExpense ? .red.opacity(0.75) : AppTheme.authPrimary)
        }
        .padding(.vertical, 10)
    }
}

#Preview {
    ReportView(onBack: {})
}

