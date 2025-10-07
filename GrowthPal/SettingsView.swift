import SwiftUI

struct SettingsView: View {
    private let quotes = [
        "Courageous defeats are more important than cowardly victories",
        "You may not be the brightest candle, but you will be the last to go out. Focus on that",
        "You may not be a champion, you may not win the game. But you will play the game you have to play",
        "Let it happen",
        "If you don't experience great losses, you can't win great victories",
        "first impressions last, you start behind the 8 ball you'll never get in front",
        "you are 1 in 400 trillion. Never forget that",
        "A tired body, tired eyes, but an ambition that does not know how to give up",
        "The sexiest thing in the world is not a beautiful face, muscles, or a tall posture. The sexiest thing is success",
        "be disgraced, ashamed, devastated, sad. But never shy away from taking that responsibility"
    ]
    
    private var randomQuote: String {
        quotes.randomElement() ?? "Lift up the hood"
    }
    
    var body: some View {
        ZStack {
            // 👇 Tüm ekranın arka planını doldurur
            Color(.appBackground)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Top title
                    HStack {
                        Text("Settings")
                            .font(.largeTitle.bold())
                        Spacer()
                    }
                    
                    // Profile and Premium buttons
                    HStack(spacing: 16) {
                        SettingsSquareButton(
                            title: "Profile",
                            subtitle: "View & edit",
                            systemImage: "person.crop.circle.fill",
                            tint: .appSecondaryAccent
                        ) {
                            // Navigate to profile (placeholder)
                        }
                        
                        SettingsSquareButton(
                            title: "Premium",
                            subtitle: "Upgrade",
                            systemImage: "tree",
                            tint: .appPrimaryAccent
                        ) {
                            // Trigger purchase (placeholder)
                        }
                    }
                    
                    // Daily quote
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Daily Quote")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        
                        Text(randomQuote)
                            .font(.title3.weight(.semibold))
                            .foregroundStyle(.primary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity, minHeight: 180, alignment: .leading)
                    .background(Color(.appSecondaryBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    
                    Spacer(minLength: 0)
                }
                .padding(20)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }

    
    
}

private struct SettingsSquareButton: View {
    let title: String
    let subtitle: String
    let systemImage: String
    let tint: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                Image(systemName: systemImage)
                    .font(.system(size: 32, weight: .semibold))
                    .foregroundStyle(tint)
                
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, minHeight: 140, alignment: .leading)
            .padding(16)
            .background(Color(.appSecondaryBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
        .buttonStyle(PlainButtonStyle())
        
        
    }
}

#Preview {
    NavigationStack { SettingsView() }
}



