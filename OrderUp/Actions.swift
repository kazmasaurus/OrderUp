//
//  Actions.swift
//  OrderUp
//
//  Created by Zak Remer on 9/21/17.
//  Copyright © 2017 Opal. All rights reserved.
//

import Foundation
import ReSwift
import Mapper

func fetchMenu() -> Store.ActionCreator {
    return { state, store in

        store.dispatch(FetchMenu.requesting)

        let menuURL = URL(string: "https://mobile-dev-code-project.s3-us-west-2.amazonaws.com/project.json")!
        URLSession.shared.dataTask(with: menuURL) { data, response, error in

            let fetchResponse: FetchMenu = {
                switch (data, error) {
                case (let data?, _):
                    // TODO: I pretty agressively hate this, but it gets the job done.
                    // I would probably lean into antitypical/Result to clean it up.

                    guard
                        let json = try? JSONSerialization.jsonObject(with: data, options: []),
                        let dict = json as? NSDictionary
                    else { return .response(.failure(JSONError())) }

                    do {
                        let menu = try Menu(map: Mapper(JSON: dict))
                        return .response(.success(menu))
                    }
                    catch { return .response(.failure(error)) }

                case (_, let error?):
                    return .response(.failure(error))

                default: fatalError()
                }
            }()

            // Since URLSession doesn't run callbacks on main.
            DispatchQueue.main.async { store.dispatch(fetchResponse) }
        }.resume()

        return nil
    }
}

struct JSONError: Error {}

enum FetchMenu: Action {
    case requesting
    case response(Result<Menu>)
}

enum Result<Element> {
    case success(Element)
    case failure(Error)
}
