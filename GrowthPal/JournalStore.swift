import Foundation
import SwiftUI
import Combine  // EKLE

@MainActor
final class JournalStore: ObservableObject {
    static let shared = JournalStore()

    @Published private(set) var entries: [Int: String] = [:] // day -> text

    private let defaultsKey = "journal.entries.october"

    private init() {
        load()
    }

    func text(for day: Int) -> String {
        entries[day] ?? ""
    }

    func setText(_ text: String, for day: Int) {
        entries[day] = text
        save()
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: defaultsKey) else { return }
        if let decoded = try? JSONDecoder().decode([Int: String].self, from: data) {
            entries = decoded
        }
    }

    private func save() {
        if let data = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(data, forKey: defaultsKey)
        }
    }
}









