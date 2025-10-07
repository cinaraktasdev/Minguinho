import SwiftUI

struct JournalEditorView: View {
    let entry: JournalEntry
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focused: Bool
    @State private var text: String = ""
    @StateObject private var store = JournalStore.shared

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 12) {
                Text(entry.isSummary ? "October Summary" : "October \(entry.day)")
                    .font(.title3.bold())
                    .padding(.top, 8)

                TextEditor(text: $text)
                    .font(.system(size: 20))
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color(.secondarySystemBackground))
                    )
                    .focused($focused)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

            }
            .padding()
            .navigationTitle("Journal")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        if !entry.isSummary {
                            store.setText(text, for: entry.day)
                        }
                        dismiss()
                    }
                }
            }
            .onAppear {
                if !entry.isSummary {
                    text = store.text(for: entry.day)
                }
                focused = true
            }
        }
    }
}

#Preview {
    JournalEditorView(entry: JournalEntry(id: UUID(), day: 3, isSummary: false))
}


