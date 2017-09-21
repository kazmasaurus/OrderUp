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

    var viewModel: ViewModel = [] {
        didSet {
            guard viewModel != oldValue else { return }
            menuTableView.reloadData()
        }
    }

    @IBOutlet weak var menuTableView: UITableView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.subscribe(self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        store.unsubscribe(self)
        super.viewWillDisappear(animated)
    }
}

extension OrderPlacingViewController: StoreSubscriber {

    func newState(state: AppState) {
        print(#file, #function, state)
        self.viewModel = OrderPlacingViewController.viewModel(from: state)
    }
}

extension OrderPlacingViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int { return 1 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let cellModel = viewModel[indexPath.item]
        cell.textLabel?.text = cellModel.item
        cell.detailTextLabel?.text = cellModel.price

        return cell
    }
}

extension OrderPlacingViewController: UITableViewDelegate {}

extension OrderPlacingViewController {
    typealias ViewModel = [Cell]

    struct Cell {
        let item: String
        let price: String
    }

    static let priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()

    static func viewModel(from state: AppState) -> ViewModel {
        return state.items.flatMap { item in
            return item.options.map {
                let price = priceFormatter.string(from: NSNumber(value: $0.price)) ?? "??"
                return Cell(item: item.name + " (\($0.size))", price: price)
            }
        }
    }
}

extension OrderPlacingViewController.Cell: Equatable {
    static func ==(lhs: OrderPlacingViewController.Cell, rhs: OrderPlacingViewController.Cell) -> Bool {
        return lhs.item == rhs.item
            && lhs.price == rhs.price
    }
}


