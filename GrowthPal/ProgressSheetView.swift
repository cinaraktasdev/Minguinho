import SwiftUI

struct ProgressSheetView: View {
    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 12) {
                Text("Progress")
                    .font(.title2.bold())
                Text("Overview of your journey")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            HStack(spacing: 24) {
                progressStat(title: "Progress %", value: "--%")
                progressStat(title: "Streak", value: "--")
            }
            .padding(.vertical, 8)

            Spacer()
        }
        .padding()
    }

    @ViewBuilder
    private func progressStat(title: String, value: String) -> some View {
        VStack(spacing: 6) {
            Text(value)
                .font(.system(size: 32, weight: .bold))
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.secondarySystemBackground))
        )
    }
}

#Preview {
    ProgressSheetView()
}



