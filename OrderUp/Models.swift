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

// If I was more comfortable with it, I would have prefered to use Swift 4's new `Decodable`
extension Menu: Mappable {
    init(map: Mapper) throws {
        items = try map.from("menu")
    }
}

extension Menu.Item: Mappable {
    init(map: Mapper) throws {
        name = try map.from("item")
        options = try map.from("options")
    }
}

extension Menu.Option: Mappable {
    init(map: Mapper) throws {
        size = try map.from("size")
        price = try map.from("price")
    }
}
