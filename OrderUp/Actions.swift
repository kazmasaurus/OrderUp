//
//  Actions.swift
//  OrderUp
//
//  Created by Zak Remer on 9/21/17.
//  Copyright © 2017 Opal. All rights reserved.
//

import Foundation
import ReSwift

func fetchMenu() -> Store.ActionCreator {
    return { state, store in

        store.dispatch(FetchMenu.requesting)

        let menuURL = URL(string: "https://mobile-dev-code-project.s3-us-west-2.amazonaws.com/project.json")!
        URLSession.shared.dataTask(with: menuURL) { data, response, error in

            let fetchResponse: FetchMenu = {
                switch (data, error) {
                case (let data?, _): return .response(.success(data))
                case (_, let error?): return .response(.failure(error))
                default: fatalError()
                }
            }()

            store.dispatch(fetchResponse)
        }.resume()

        return nil
    }
}

enum FetchMenu: Action {
    case requesting
    case response(Result<Data>)
}

enum Result<Element> {
    case success(Element)
    case failure(Error)
}
