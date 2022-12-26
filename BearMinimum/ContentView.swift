//
//  ContentView.swift
//  BearMinimum
//
//  Created by Ron Friedman on 2022-12-22.
//

import SwiftUI
import AVKit
import ConfettiSwiftUI

struct ContentView: View {
    @State var tasks = TaskManager.tasks
    @AppStorage("CurrentStreak") var dayCount = 0
    @State var successPlayer: AVAudioPlayer!
    @State var yipeePlayer: AVAudioPlayer!
    
    var body: some View {
        let completeCount = tasks.filter(\.isComplete).count
        let completeStatus = completeCount == tasks.count
        
        VStack {
            // Top bar
            HStack {
                BearImageCircle()
                Text("Bear Minimum")
                    .font(Font.custom("JosefinSans-Medium", size: 35)).padding()
            }
            
            Text("Daily Tasks:").font(.title2)
            Text(String(completeCount) + "/" + String(tasks.count))
                .padding().font(.system(size: 20, weight: .bold, design: .default))
            
            // Task list
            ScrollView {
                ForEach($tasks) { $task in
                    Toggle(task.id, isOn: $task.isComplete).padding().tint(.accentColor)
                        .onChange(of: task.isComplete) { value in
                            TaskManager.save()
                            
                            if (task.isComplete) {
                                successPlayer.stop()
                                successPlayer.play()
                            }
                        }
                    
                }
                .disabled(completeStatus)
            }
            
            if  completeStatus {
                Text("All done! Congratulations.")
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
            
            Text("Current Streak: " + String(dayCount) + " days.")
                .padding()
                .font(.system(size: 20, weight: .bold, design: .default))
                .confettiCannon(counter: $dayCount, num: 130, colors: [.orange, .accentColor, .white, .brown], rainHeight: 1500, radius: 550)
            Spacer()
        }
        .background(completeStatus ? Color.accentColor.opacity(0.35) : .white) // Fade to yellow when all tasks are done
        .animation(.easeInOut, value: completeStatus)
        .onAppear(){
            // Initialize audio players
            successPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Success", ofType: "mp3")!))
            yipeePlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource: "Yipee", ofType: "mp3")!))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
