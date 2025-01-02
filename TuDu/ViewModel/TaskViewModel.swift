//
//  TaskViewModel.swift
//  TuDu
//
//  Created by Hai Lam Nguyen on 2/1/25.
//

import Foundation

class TaskViewModel: ObservableObject {
    @Published var taskList: [TaskModel] = []
//    @Published var taskDoingFiltered: [TaskModel] = []
//    @Published var taskFinishedFiltered: [TaskModel] = []
    
    init() {
        getDefaultTaskList()
    }
    
    func getDefaultTaskList() {
        let defaultTaskList = [
            TaskModel(title: "Cleaning House", isFinished: false),
            TaskModel(title: "Feed The Dog", isFinished: true),
            TaskModel(title: "Hangout With Friends", isFinished: false),
            TaskModel(title: "Gym at 4pm", isFinished: false),
            TaskModel(title: "Ice Cream", isFinished: true),
        ]
        taskList.append(contentsOf: defaultTaskList)
    }
    
    func addTask(name: String) {
        let newTask = TaskModel(title: name, isFinished: false)
        taskList.append(newTask)
        print("Task name: \(newTask.title) - Added")
    }
    
    func deleteTask(indexSet: IndexSet) {
        taskList.remove(atOffsets: indexSet)
    }
    
    func moveTask(from: IndexSet, to: Int) {
        taskList.move(fromOffsets: from, toOffset: to)
    }
}
