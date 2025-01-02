//
//  TaskModel.swift
//  TuDu
//
//  Created by Hai Lam Nguyen on 2/1/25.
//

import Foundation

struct TaskModel: Identifiable {
    let id = UUID()
    let title: String
    var isFinished: Bool
}
