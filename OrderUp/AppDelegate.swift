//
//  AppDelegate.swift
//  OrderUp
//
//  Created by Zak Remer on 9/21/17.
//  Copyright © 2017 Opal. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let store = Store(reducer: AppState.reducer, state: AppState(), middleware: [])

    // I'm living with the force unwrap as a compromise that comes with using Storyboards to get this up and running.

    var orderPlacingViewController: OrderPlacingViewController! {
        return tabBarViewController.viewControllers?[0] as? OrderPlacingViewController
    }

    var orderViewingViewController: OrderViewingViewController! {
        return tabBarViewController.viewControllers?[1] as? OrderViewingViewController
    }

    var tabBarViewController: UITabBarController! {
        return (window?.rootViewController as? UITabBarController)
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        orderViewingViewController.store = store
        orderPlacingViewController.store = store

        store.dispatch(fetchMenu())

        return true
    }
}

