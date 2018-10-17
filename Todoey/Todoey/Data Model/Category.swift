//
//  Category.swift
//  Todoey
//
//  Created by Jerry on 10/8/18.
//  Copyright © 2018 AppTweaker. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var colour: String = ""
    let items = List<Item>()
}
