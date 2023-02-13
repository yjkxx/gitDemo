//
//  TodoModel.swift
//  JSONtodo
//
//  Created by YoungJoon Kim on 2/11/23.
//

import Foundation

struct TodoModel: Codable {
    
    var userId: Int?
    var id: Int?
    var title: String?
    var completed: Bool?
}
