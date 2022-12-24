//
//  TaskListView.swift
//  BearMinimum
//
//  Created by Ron Friedman on 2022-12-22.
//

import SwiftUI

struct TaskListView: View {
    @Binding var tasks: [Task]
    @AppStorage("CurrentStreak") var dayCount = 0
    var body: some View {
        
        let completeCount = tasks.filter(\.isComplete).count
        let completeStatus = completeCount == tasks.count
        
        VStack {
            Text(String(completeCount) + "/" + String(tasks.count))
                .padding().font(.system(size: 20, weight: .bold, design: .default))
            ScrollView {
                ForEach($tasks) { $task in
                    Toggle(task.id, isOn: $task.isComplete).padding().tint(.yellow)
                        .onChange(of: task.isComplete) { value in
                            TaskManager.save()
                        }
                }
                .disabled(completeStatus)
                
                if  completeStatus {
                    
                    Text("All done! Yippee!!!!")
                    Text("Come back tomorrow :)")
                    ExecuteCode {
                        if (!Calendar.current.isDateInToday(TaskManager.lastCompleted)) { // If a day has passed since last completed
                            dayCount += 1
                            TaskManager.lastCompleted = Date()
                        }
                        
                        TaskManager.save()
                        
                    }
                }
            }
            Text("Current Streak: " + String(dayCount) + " days.")
                .padding()
                .font(.system(size: 20, weight: .bold, design: .default))
        }
    }
}

// https://stackoverflow.com/questions/63090325/how-to-execute-non-view-code-inside-a-swiftui-view
struct ExecuteCode : View {
    init( _ codeToExec: () -> () ) {
        codeToExec()
    }
    
    var body: some View {
        return EmptyView()
    }
}
