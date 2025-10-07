//
//  JournalView.swift
//  GrowthPal
//
//  Created by ÇINAR AKTAŞ on 5.10.2025.
//

import SwiftUI

struct JournalView: View {
    @StateObject private var store = JournalStore.shared
    @State private var selectedEntry: JournalEntry?
    
    private let currentMonth = 10 // October
    private let currentYear = 2025
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Arka plan rengi
                Color(.appBackground)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // October Summary section at top
                    VStack(alignment: .leading, spacing: 12) {
                        Text("October 2025")
                            .font(.title2.bold())
                            .padding(.horizontal, 20)
                            .padding(.top, 16)
                        
                        Button {
                            let summaryEntry = JournalEntry(id: UUID(), day: 0, isSummary: true)
                            selectedEntry = summaryEntry
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("October Summary")
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(.primary)
                                    
                                    Text("Reflect on your month")
                                        .font(.system(size: 14))
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.secondary)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 16)
                            .background(
                                Capsule()
                                    .fill(Color(.secondarySystemBackground))
                            )
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.horizontal, 20)
                    }
                    
                    Divider()
                        .padding(.vertical, 16)
                    
                    // Vertical scrollable days
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack(spacing: 12) {
                            ForEach(1...31, id: \.self) { day in
                                let entry = JournalEntry(id: UUID(), day: day, isSummary: false)
                                let hasContent = !store.text(for: day).isEmpty
                                let dayText = store.text(for: day)
                                let previewText = dayText.isEmpty ? "Write something..." : String(dayText.prefix(80)) + (dayText.count > 80 ? "..." : "")
                                
                                Button {
                                    selectedEntry = entry
                                } label: {
                                    HStack(spacing: 16) {
                                        VStack(alignment: .leading, spacing: 8) {
                                            HStack {
                                                Text("\(day)")
                                                    .font(.system(size: 24, weight: .bold))
                                                    .foregroundColor(.primary)
                                                
                                                Text("October")
                                                    .font(.system(size: 16, weight: .medium))
                                                    .foregroundColor(.secondary)
                                                
                                                Spacer()
                                                
                                                if hasContent {
                                                    Circle()
                                                        .fill(Color.blue)
                                                        .frame(width: 10, height: 10)
                                                }
                                            }
                                            
                                            Text(previewText)
                                                .font(.system(size: 14))
                                                .foregroundColor(hasContent ? .primary : .secondary)
                                                .multilineTextAlignment(.leading)
                                                .lineLimit(2)
                                        }
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                            .font(.system(size: 14, weight: .medium))
                                            .foregroundColor(.secondary)
                                    }
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, 16)
                                    .background(
                                        Capsule()
                                            .fill(hasContent ? Color.blue.opacity(0.1) : Color(.secondarySystemBackground))
                                            .overlay(
                                                Capsule()
                                                    .stroke(hasContent ? Color.blue.opacity(0.3) : Color.clear, lineWidth: 1)
                                            )
                                    )
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                    }
                    
                    Spacer()
                }
            }
            .navigationTitle("Journal")
            .sheet(item: $selectedEntry) { entry in
                JournalEditorView(entry: entry)
            }
        }
    }
}

#Preview {
    JournalView()
}
