//
//  BearMinimumApp.swift
//  BearMinimum
//
//  Created by Ron Friedman on 2022-12-22.
//

import SwiftUI

@main
struct BearMinimumApp: App {
    
    init() {
        let defaults = UserDefaults.standard
        TaskManager.load()
        
        // Initialize UserDefaults if they do not exist
        if (TaskManager.tasks.isEmpty) {
            TaskManager.tasks = [
                Task(id: "Breakfast"),
                Task(id: "Lunch"),
                Task(id: "Dinner"),
                Task(id: "Protein"),
                Task(id: "Exercise")] // Default content
        }
        
        if (defaults.object(forKey: "CurrentStreak") == nil) {
            defaults.set(0, forKey: "CurrentStreak") // Default value
        }
        
        // Reset checkmarks if we are on a new day
        if(!Calendar.current.isDateInToday(TaskManager.lastAccessed)) {
            TaskManager.unCheckAll()
            if (!Calendar.current.isDateInYesterday(TaskManager.lastCompleted)) { // Streak broken! Oh no...
                defaults.set(0, forKey: "CurrentStreak")
            }
        }
        
        
       
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
