import SwiftUI

struct SleepView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "bed.double")
                .font(.system(size: 48, weight: .regular))
            Text("Sleep")
                .font(.title.bold())
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.appBackground))
    }
}

#Preview {
    SleepView()
}



