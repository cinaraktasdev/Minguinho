import SwiftUI

struct FitnessView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "dumbbell")
                .font(.system(size: 48, weight: .regular))
            Text("Fitness")
                .font(.title.bold())
                .foregroundColor(.appTextPrimary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.appBackground))
    }
}

#Preview {
    FitnessView()
}



