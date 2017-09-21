//
//  FirstViewController.swift
//  OrderUp
//
//  Created by Zak Remer on 9/21/17.
//  Copyright © 2017 Opal. All rights reserved.
//

import UIKit
import ReSwift

class OrderPlacingViewController: UIViewController {

    var store: Store!

    var viewModel: ViewModel = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.subscribe(self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        store.unsubscribe(self)
    }
}

extension OrderPlacingViewController: StoreSubscriber {

    func newState(state: AppState) {
        print(#file, #function, state)
        print(OrderPlacingViewController.viewModel(from: state))
    }
}

//extension OrderPlacingViewController:



extension OrderPlacingViewController {
    typealias ViewModel = [Cell]

    struct Cell {
        let itemName: String // TODO: Don't really like the weak typing
        let option: Menu.Option
    }

    static func viewModel(from state: AppState) -> ViewModel {
        return state.items.flatMap { item in
            return item.options.map { Cell(itemName: item.name, option: $0) }
        }
    }
}



