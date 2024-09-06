//
//  AppDelegate.swift
//  TravelVista
//
//  Created by Amandine Cousin on 13/12/2023.
//

import UIKit
import SwiftUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setHostingControllerForListView()
        return true
    }
}

// MARK: SwiftUI migration

extension AppDelegate {

    private func setHostingControllerForListView() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let hostingController = UIHostingController(rootView: ListView())
        window?.rootViewController = hostingController
        window?.makeKeyAndVisible()
    }
}
