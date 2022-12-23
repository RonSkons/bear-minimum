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
                Image("Bear")
                    .resizable().frame(width: 128, height: 128)
                    .clipShape(Circle())
                    .overlay {

                        Circle().stroke(.white, lineWidth: 4)

                    }
                    .shadow(radius: 7)
                Text("Bear Minimum")
                    .font(.title).padding()
            }
            
            Text("Daily Tasks:").font(.title2).padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
