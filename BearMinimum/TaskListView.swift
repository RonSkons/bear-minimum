//
//  TaskListView.swift
//  BearMinimum
//
//  Created by Ron Friedman on 2022-12-22.
//

import SwiftUI
import AVKit

struct TaskListView: View {
    @Binding var tasks: [Task]
    @AppStorage("CurrentStreak") var dayCount = 0
    @State var successPlayer: AVAudioPlayer!
    @State var yipeePlayer: AVAudioPlayer!
    
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
                            
                            if (task.isComplete) {
                                successPlayer.stop()
                                successPlayer.play()
                            }
                        }
                    
                }
                .disabled(completeStatus)
                
                if  completeStatus {
                    Text("All done! Yippee!!!!")
                    Text("Come back tomorrow :)")
                        .onAppear {
                            if (!Calendar.current.isDateInToday(TaskManager.lastCompleted)) { // If a day has passed since last completed
                                dayCount += 1
                                TaskManager.lastCompleted = Date()
                                successPlayer.stop()
                                yipeePlayer.play()
                            }
                            
                            TaskManager.save()
                        }
                }
            }
            Text("Current Streak: " + String(dayCount) + " days.")
                .padding()
                .font(.system(size: 20, weight: .bold, design: .default))
        }
        .onAppear(){
            successPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Success", ofType: "mp3")!))
            yipeePlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Yipee", ofType: "mp3")!))
        }
    }
}
