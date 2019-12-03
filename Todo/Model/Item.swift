//
//  Item.swift
//  Todo
//
//  Created by Muhammad Asad Chattha on 02/12/2019.
//  Copyright © 2019 Muhammad Asad Chattha. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date?
    
    let parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
