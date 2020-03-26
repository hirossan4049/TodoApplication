//
//  Todo.swift
//  TodoApplication
//
//  Created by linear on 2020/03/25.
//  Copyright © 2020 linear. All rights reserved.
//

import Foundation
import RealmSwift


class Todo:Object {
    dynamic var title: String? = nil
    dynamic var updateTime: Date? = nil
    dynamic var isDone:Bool? = false
    
//    @objc dynamic var category: String? = nil
    
}
