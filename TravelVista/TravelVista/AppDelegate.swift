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
        guard let window = window else {
            return
        }
        let regions: [Region] = Service().load("Source.json")
        let hostingController = UIHostingController(rootView: ListView(regions: regions))
        
        if let oldRootViewController = window.rootViewController {
            oldRootViewController.view.removeFromSuperview()
            oldRootViewController.removeFromParent()
        }
        window.rootViewController = hostingController
        window.makeKeyAndVisible()
    }
}
