//
//  ToDoListView.swift
//  TuDu
//
//  Created by Hai Lam Nguyen on 1/1/25.
//

import SwiftUI

struct ToDoListView: View {
    @State var isPresented: Bool = false
    @State var isSwitched: Bool = false
    @StateObject var viewModel = TaskViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    List {
                        Section(footer:
                                    Text("Tap to mark as Done. Swipe left to Delete. Hold and drag to Arrange")) {
                            ForEach($viewModel.taskList) { task in
                                ToDoItemView(task: task)
                            }
                            .onDelete(perform: viewModel.deleteTask)
                            .onMove(perform: viewModel.moveTask)
                        }
                    }
                }
                VStack {
                    Spacer()
                    PrimaryButton(buttonContent: "Add Your Task") {
                        print("Go To Add Item")
                        isPresented.toggle()
                    }
                }
            }
            .navigationTitle("To Do List")
            .sheet(isPresented: $isPresented) {
                AddItemView(isPresentedSheet: $isPresented, viewModel: viewModel)
//                    .presentationDetents([.large, .medium])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}

struct ToDoItemView: View {
    @Binding var task: TaskModel
    var body: some View {
        Button {
            print("""
               ID: \(task.id)
               Name: \(task.title)
               Done Status: \(task.isFinished)
               --------------------
               """)
            task.isFinished.toggle()
        } label: {
            HStack {
                Image(systemName: task.isFinished ? "checkmark.circle" : "circle")
                Text(task.title)
            }
            .foregroundStyle(task.isFinished ? Color.gray.opacity(0.6) : Color.black)
        }
    }
}

struct AddItemView: View {
    @State var taskNameTyping: String = ""
    @Binding var isPresentedSheet: Bool
    @ObservedObject var viewModel: TaskViewModel
    @FocusState var isFocused: Bool
    
    var body: some View {
        NavigationView {
            VStack (spacing: 16) {
                TaskTextField(placeholder: "Your task name...", textTyping: $taskNameTyping)
                    .focused($isFocused)
                Spacer()
                PrimaryButton(buttonContent: "Add Your Task") {
                    viewModel.addTask(name: taskNameTyping)
                    isPresentedSheet.toggle()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        print("Go back")
                        isPresentedSheet.toggle()
                    } label: {
                        Text("Done")
                    }
                }
            }
            .navigationTitle("Add Your Task")
        }
        .onAppear {
            isFocused = true
            print("Add View Accessed")
        }
    }
}

// MARK: Components
struct TaskTextField: View {
    var placeholder: String
    @Binding var textTyping: String
    
    var body: some View {
        TextField(placeholder, text: $textTyping)
            .font(.system(size: 16, weight: .regular))
            .padding(.horizontal, 12)
            .foregroundStyle(Color.gray)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(12)
            .padding(.horizontal, 16)
    }
}

struct PrimaryButton: View {
    let buttonContent: String
    var action: () -> Void = { }
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(systemName: "plus")
                Text(buttonContent)
            }
            .font(.system(size: 16, weight: .semibold))
            .foregroundStyle(Color.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.accentColor)
            .cornerRadius(12)
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }
}

#Preview {
    ToDoListView()
}
