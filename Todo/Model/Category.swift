//
//  Category.swift
//  Todo
//
//  Created by Muhammad Asad Chattha on 02/12/2019.
//  Copyright © 2019 Muhammad Asad Chattha. All rights reserved.
//

import Foundation
import RealmSwift


class Category: Object{
    
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    
    let items = List<Item>()
}
