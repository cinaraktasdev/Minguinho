//
//  TodoListView.swift
//  GrowthPal
//
//  Created by ÇINAR AKTAŞ on 5.10.2025.
//

import SwiftUI
import Combine

struct TodoItem: Identifiable, Codable {
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
    var createdAt: Date = Date()
}

@MainActor
class TodoStore: ObservableObject {
    static let shared = TodoStore()
    
    @Published var todos: [TodoItem] = []
    
    private let userDefaultsKey = "todos"
    
    private init() {
        loadTodos()
    }
    
    func addTodo(_ title: String) {
        let newTodo = TodoItem(title: title)
        todos.append(newTodo)
        saveTodos()
    }
    
    func toggleTodo(_ todo: TodoItem) {
        if let index = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[index].isCompleted.toggle()
            saveTodos()
        }
    }
    
    func deleteTodo(_ todo: TodoItem) {
        todos.removeAll { $0.id == todo.id }
        saveTodos()
    }
    
    private func loadTodos() {
        if let data = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decoded = try? JSONDecoder().decode([TodoItem].self, from: data) {
            todos = decoded
        }
    }
    
    private func saveTodos() {
        if let data = try? JSONEncoder().encode(todos) {
            UserDefaults.standard.set(data, forKey: userDefaultsKey)
        }
    }
}

struct TodoListView: View {
    @StateObject private var store = TodoStore.shared
    @State private var newTodoTitle = ""
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.appBackground)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    VStack(spacing: 16) {
                        HStack(spacing: 12) {
                            TextField("What needs to be done?", text: $newTodoTitle)
                                .font(.system(size: 18, weight: .medium))
                                .padding(.horizontal, 20)
                                .padding(.vertical, 16)
                                .background(
                                    Capsule()
                                        .fill(Color(.secondarySystemBackground))
                                )
                                .focused($isTextFieldFocused)
                                .onSubmit {
                                    addTodo()
                                }
                            
                            Button {
                                addTodo()
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 32))
                                    .foregroundColor(newTodoTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? .secondary : .blue)
                            }
                            .disabled(newTodoTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 16)
                        
                        if !store.todos.isEmpty {
                            HStack {
                                Text("\(store.todos.count)/6 todos")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Spacer()
                                Text("\(store.todos.filter { $0.isCompleted }.count) completed")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    
                    Divider()
                        .padding(.top, 16)
                    
                    if store.todos.isEmpty {
                        VStack(spacing: 16) {
                            Image(systemName: "checkmark.circle")
                                .font(.system(size: 48, weight: .regular))
                                .foregroundColor(.secondary)
                            Text("No todos yet")
                                .font(.title2)
                                .foregroundColor(.secondary)
                            Text("Add your first todo to get started")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 12) {
                                ForEach(store.todos) { todo in
                                    TodoRowView(todo: todo, store: store)
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.top, 16)
                        }
                    }
                }
            }
            .navigationTitle("ToDo")
            .onAppear {
                isTextFieldFocused = true
            }
        }
    }
    
    private func addTodo() {
        let trimmedTitle = newTodoTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedTitle.isEmpty && store.todos.count < 6 else { return }
        
        store.addTodo(trimmedTitle)
        newTodoTitle = ""
    }
}

struct TodoRowView: View {
    let todo: TodoItem
    let store: TodoStore
    
    var body: some View {
        HStack(spacing: 16) {
            Button {
                store.toggleTodo(todo)
            } label: {
                Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(todo.isCompleted ? .green : .secondary)
            }
            .buttonStyle(PlainButtonStyle())
            
            VStack(alignment: .leading, spacing: 6) {
                Text(todo.title)
                    .font(.system(size: 18, weight: .medium))
                    .strikethrough(todo.isCompleted)
                    .foregroundColor(todo.isCompleted ? .secondary : .primary)
                    .multilineTextAlignment(.leading)
                
                Text(todo.createdAt, style: .date)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button {
                store.deleteTodo(todo)
            } label: {
                Image(systemName: "trash")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.red)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(
            Capsule()
                .fill(todo.isCompleted ? Color.green.opacity(0.1) : Color(.secondarySystemBackground))
        )
    }
}

#Preview {
    TodoListView()
}
