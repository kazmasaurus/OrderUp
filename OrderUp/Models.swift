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

    var items: [Item] {
        return itemTypes.flatMap { type in
            return type.options.map { Item(itemType: type, option: $0) }
        }
    }

    private let itemTypes: [ItemType]

    struct Item {
        let itemType: ItemType
        let option: Option

        var name: String { return itemType.name }
        var size: String { return option.size }
        var price: Double { return option.price }
    }

    struct ItemType {
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
        itemTypes = try map.from("menu")
    }
}

extension Menu.ItemType: Mappable {
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

extension Menu.Item: Equatable {
    static func ==(lhs: Menu.Item, rhs: Menu.Item) -> Bool {
        return lhs.itemType == rhs.itemType
            && lhs.option == rhs.option
    }
}

extension Menu.ItemType: Equatable {
    static func ==(lhs: Menu.ItemType, rhs: Menu.ItemType) -> Bool {
        return lhs.name == rhs.name
            && lhs.options == rhs.options
    }
}

extension Menu.Option: Equatable {
    static func == (lhs: Menu.Option, rhs: Menu.Option) -> Bool {
        return lhs.price == rhs.price
            && lhs.size == rhs.size
    }
}

