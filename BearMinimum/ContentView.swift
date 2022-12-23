//
//  ContentView.swift
//  BearMinimum
//
//  Created by Ron Friedman on 2022-12-22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            HStack {
                BearImageCircle()
                Text("Bear Minimum")
                    .font(.title).padding()
            }
            
            Text("Daily Tasks:").font(.title2)
            TaskListView()
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
