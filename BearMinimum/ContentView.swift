//
//  ContentView.swift
//  BearMinimum
//
//  Created by Ron Friedman on 2022-12-22.
//

import SwiftUI

struct ContentView: View {
    @State var tasks = TaskManager.tasks
    var body: some View {
        let yellow = tasks.filter(\.isComplete).count == tasks.count
        VStack {
            HStack {
                BearImageCircle()
                Text("Bear Minimum")
                    .font(.title).padding()
            }
            
            Text("Daily Tasks:").font(.title2)
            TaskListView(tasks: self.$tasks)
            Spacer()
        }
        .background(yellow ? .yellow.opacity(0.4) : .white)
        .animation(.easeInOut, value: yellow)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
