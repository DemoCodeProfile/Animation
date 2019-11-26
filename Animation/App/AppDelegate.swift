//
//  AppDelegate.swift
//  Animation
//
//  Copyright © 2019 Вадим. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = AnimationTextRouter.createModule()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        return true
    }
}
