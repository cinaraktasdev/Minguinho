//
//  JournalEntry.swift
//  GrowthPal
//
//  Created by ÇINAR AKTAŞ on 5.10.2025.
//
import Foundation

struct JournalEntry: Identifiable, Hashable {
    let id: UUID
    let day: Int
    let isSummary: Bool
}
