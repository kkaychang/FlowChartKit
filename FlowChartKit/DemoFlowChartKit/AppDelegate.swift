//
//  AppDelegate.swift
//  DemoFlowChartKit
//
//  Created by Kay Chang on 2022/1/16.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = ViewController()
        let nv = UINavigationController(rootViewController: vc)
        window?.rootViewController = nv
        window?.makeKeyAndVisible()
        return true
    }
    
}

