//
//  ContentView.swift
//  GrowthPal
//
//  Created by ÇINAR AKTAŞ on 5.10.2025.
//

import SwiftUI

struct ContentView: View {
    private enum Tab: Int, CaseIterable {
        case meditate = 0
        case fitness
        case todo
        case sleep
        case journal
    }

    @State private var selectedTab: Tab = .meditate
    @State private var showProgressSheet: Bool = false
    @State private var navigateToSettings: Bool = false
    @State private var demoProgress: Double = 0.42

    var body: some View {
        NavigationStack {
            ZStack {
                TabView(selection: $selectedTab) {
                    MeditateView()
                        .tabItem {
                            Image(systemName: "leaf")
                            Text("Meditate")
                        }
                        .tag(Tab.meditate)

                    FitnessView()
                        .tabItem {
                            Image(systemName: "dumbbell")
                            Text("Fitness")
                        }
                        .tag(Tab.fitness)

                    TodoListView()
                        .tabItem {
                            Image(systemName: "plus.circle")
                            Text("ToDo")
                        }
                        .tag(Tab.todo)

                    SleepView()
                        .tabItem {
                            Image(systemName: "bed.double")
                            Text("Sleep")
                        }
                        .tag(Tab.sleep)

                    JournalView()
                        .tabItem {
                            Image(systemName: "book.closed")
                            Text("Journal")
                        }
                        .tag(Tab.journal)
                }
                .gesture(horizontalSwipeGesture)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        navigateToSettings = true
                    } label: {
                        Image(systemName: "line.3.horizontal")
                    }
                    .accessibilityLabel("Settings")
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showProgressSheet = true
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "tree")
                                .foregroundColor(.appSecondaryAccent)
                    
                            Spacer()
                            
                            CircularProgressView(progress: demoProgress)
                                .frame(width: 24, height: 24)
                            Text("\(Int(demoProgress * 100))%")
                                .font(.subheadline)
                                .foregroundStyle(.primary)
                        }
                        .padding(.horizontal, 1)
                        .padding(.vertical, 6)

                    }
                    .accessibilityLabel("Progress")
                }
            }
            .sheet(isPresented: $showProgressSheet) {
                ProgressSheetView()
                    .presentationDetents([.medium, .large])
            }
            .navigationDestination(isPresented: $navigateToSettings) {
                SettingsView()
            }
        }
    }

    private var horizontalSwipeGesture: some Gesture {
        DragGesture(minimumDistance: 20, coordinateSpace: .local)
            .onEnded { value in
                let horizontalTranslation = value.translation.width
                // Swipe left: go to next tab (if available)
                if horizontalTranslation < -40 {
                    moveSelection(by: 1)
                }
                // Swipe right: go to previous tab (if available)
                else if horizontalTranslation > 40 {
                    moveSelection(by: -1)
                }
            }
    }

    private func moveSelection(by offset: Int) {
        let all = Tab.allCases
        guard let currentIndex = all.firstIndex(of: selectedTab) else { return }
        let newIndex = max(0, min(all.count - 1, currentIndex + offset))
        withAnimation(.easeInOut(duration: 0.22)) {
            selectedTab = all[newIndex]
        }
    }
}

struct CircularProgressView: View {
    let progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(.systemGray5), lineWidth: 3)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.appSecondaryAccent,
                    style: StrokeStyle(lineWidth: 3, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
        }
    }
}

#Preview {
    ContentView()
}
