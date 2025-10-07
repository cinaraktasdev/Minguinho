import SwiftUI

struct MeditateView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "leaf")
                .font(.system(size: 48, weight: .regular))
            Text("Meditate")
                .font(.title.bold())
                .foregroundColor(.appTextPrimary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.appBackground))
    }
}

#Preview {
    MeditateView()
}



