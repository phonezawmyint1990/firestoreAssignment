//
//  TaskVO.swift
//  firestoreAssignment
//
//  Created by Aung Ko Ko on 26/10/2019.
//  Copyright © 2019 Phone Zaw Myint. All rights reserved.
//

import Foundation
struct TaskVO {
    var name : String?
    var done : Bool
    var id: String
    
    var dictionary: [String: Any] {
        return
            [ "name": name,
              "done": done]
    }
}

extension TaskVO{
    init?(dictionary:[String: Any],id: String) {
        guard let name = dictionary["name"] as? String, let done = dictionary["done"] as?  Bool else {return nil}
        self.init(name: name, done: done, id: id)
    }
}
