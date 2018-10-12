//
//  Item.swift
//  Todoey
//
//  Created by Jerry on 10/8/18.
//  Copyright © 2018 AppTweaker. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
