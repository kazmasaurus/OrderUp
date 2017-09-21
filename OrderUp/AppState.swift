//
//  AppState.swift
//  OrderUp
//
//  Created by Zak Remer on 9/21/17.
//  Copyright © 2017 Opal. All rights reserved.
//

import Foundation
import ReSwift

typealias Store = ReSwift.Store<AppState>

struct AppState {

    var menu: Menu?
}

extension AppState: StateType {
    static func reducer(action: Action, state: AppState?) -> AppState {
        var state = state ?? AppState()

        switch action {
        case FetchMenu.requesting: break // TODO: set state to loading
        case FetchMenu.response(.success(let menu)): state.menu = menu
        case FetchMenu.response(.failure): break // TODO: Set state to error
        default: break
        }

        return state
    }
}

