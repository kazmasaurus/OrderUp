//
//  Models.swift
//  OrderUp
//
//  Created by Zak Remer on 9/21/17.
//  Copyright © 2017 Opal. All rights reserved.
//

import Foundation
import Mapper



struct Menu {

    let items: [Item]

    struct Item {
        let name: String
        let options: [Option]
    }

    struct Option {
        let size: String
        let price: Double
    }
}

extension Menu: Mappable {
    init(map: Mapper) throws {
        items = try map.from("menu")
    }
}

extension Menu.Item: Mappable {
    init(map: Mapper) throws {
        name = try map.from("item")
        options = []
    }
}
