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

// MARK: Migration

extension AppDelegate {

    private func setHostingControllerForListView() {
        guard let rootVC =  window?.rootViewController else {
            return
        }
        let regions: [Region] = Service().load("Source.json")
        let hostingController = UIHostingController(rootView: ListView(regions: regions))
        rootVC.addChild(hostingController)
        rootVC.view.addSubview(hostingController.view)
        hostingController.didMove(toParent: rootVC)
    }
}
