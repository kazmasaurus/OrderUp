//
//  SecondViewController.swift
//  OrderUp
//
//  Created by Zak Remer on 9/21/17.
//  Copyright © 2017 Opal. All rights reserved.
//

import UIKit
import ReSwift

class OrderViewingViewController: UIViewController {

    var store: Store!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.subscribe(self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        store.unsubscribe(self)
    }
}

extension OrderViewingViewController: StoreSubscriber {

    func newState(state: AppState) {
        print(#file, #function, state)
    }
}
