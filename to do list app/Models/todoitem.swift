//
//  todoitem.swift
//  to do list app
//
//  Created by Donald Colin on 14/08/24.
//

import Foundation

import Foundation

struct Todoitem: Identifiable, Codable, Equatable {
    let id: String
    let title: String
    let dueDate: TimeInterval
    let createdDate: TimeInterval
    var isDone: Bool
    
    // Equatable conformance
    static func ==(lhs: Todoitem, rhs: Todoitem) -> Bool {
        return lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.dueDate == rhs.dueDate &&
        lhs.createdDate == rhs.createdDate &&
        lhs.isDone == rhs.isDone
        
        }
    }
    

    // Method to update the `isDone` state

