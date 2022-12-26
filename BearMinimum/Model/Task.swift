//
//  Task.swift
//  BearMinimum
//
//  Created by Ron Friedman on 2022-12-23.
//

import Foundation

class Task: Identifiable, Codable {
    var id: String
    var isComplete = false
    
    init(id: String, isComplete: Bool = false) {
        self.id = id
        self.isComplete = isComplete
    }
}
