//
//  AppDelegate.swift
//  ITSimulator
//
//  Created by Евгений Васильев on 15.11.2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let tabBar = MainTabBarController()
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootNC = UINavigationController(rootViewController: tabBar)
        window?.rootViewController = rootNC
        window?.makeKeyAndVisible()
        return true
    }

}
