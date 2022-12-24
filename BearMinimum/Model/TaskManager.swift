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
        var tempDict: [String:Bool] = [:]
        for task in tasks {
            tempDict[task.id] = task.isComplete
        }
        defaults.set(tempDict, forKey: "TaskManager")
        defaults.set(lastCompleted, forKey: "LastCompletedDate")
        defaults.set(Date(), forKey: "LastAccessedDate")
    }
    
    // Loads saved values to class
    static func load() {
        guard let tempDict = defaults.dictionary(forKey: "TaskManager") else {return}
        for (name, value) in tempDict {
            tasks.append(Task(id: name, isComplete: value as! Bool))
        }
        var tempDate = defaults.object(forKey: "LastCompletedDate")
        if (tempDate != nil) {
            lastCompleted = tempDate as! Date
        }
        tempDate = defaults.object(forKey: "LastAccessedDate")
        if (tempDate != nil) {
            lastAccessed = tempDate as! Date
        }
    }
    
    // Unchecks all tasks in the list
    static func unCheckAll() {
        for task in tasks {
            task.isComplete = false;
        }
    }
}
