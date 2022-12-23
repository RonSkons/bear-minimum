//
//  TaskListView.swift
//  BearMinimum
//
//  Created by Ron Friedman on 2022-12-22.
//

import SwiftUI

struct Task: Identifiable {
    var id: String
    var isComplete = false
}

struct TaskListView: View {
    @State var tasks = [
    Task(id: "Breakfast"),
    Task(id: "Lunch"),
    Task(id: "Dinner"),
    Task(id: "Protein"),
    Task(id: "Exercise")]
    var body: some View {
        let completeCount = tasks.filter(\.isComplete).count
        
        VStack {
            Text(String(completeCount) + "/" + String(tasks.count))
                .padding().font(.system(size: 20, weight: .bold, design: .default))
            ScrollView {
                ForEach($tasks) { $task in
                    Toggle(task.id, isOn: $task.isComplete).padding().tint(.yellow)
                }
                
                if  completeCount == tasks.count {
                    Text("All done! Yippee!!!!")
                }
            }
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
