//
//  TaskList.swift
//  BearMinimum
//
//  Created by Ron Friedman on 2022-12-23.
//

import Foundation

// Manages the list of tasks
class TaskManager {
    static var tasks: [Task] = []
    static var lastCompleted: Date = Date(timeIntervalSince1970: 0) // Placeholder value
    static var lastAccessed: Date = Date() // Placeholder value
    
    private static let defaults = UserDefaults.standard
    
    // Saves class values to userdefaults
    static func save() {
        var temp: [(String, Bool)] = []
        for task in tasks {
            temp.append((task.id, task.isComplete))
        }
        defaults.set(try! PropertyListEncoder().encode(tasks), forKey: "TaskManager")
        defaults.set(lastCompleted, forKey: "LastCompletedDate")
        defaults.set(Date(), forKey: "LastAccessedDate")
    }
    
    // Loads saved values to class
    static func load() {
        if let temp = UserDefaults.standard.data(forKey: "TaskManager") {
            tasks = try! PropertyListDecoder().decode([Task].self, from: temp)
            
            var tempDate = defaults.object(forKey: "LastCompletedDate")
            if (tempDate != nil) {
                lastCompleted = tempDate as! Date
            }
            tempDate = defaults.object(forKey: "LastAccessedDate")
            if (tempDate != nil) {
                lastAccessed = tempDate as! Date
            }
        } else {
            return
        }
        
    }
    
    // Unchecks all tasks in the list
    static func unCheckAll() {
        for task in tasks {
            task.isComplete = false;
        }
    }
}
