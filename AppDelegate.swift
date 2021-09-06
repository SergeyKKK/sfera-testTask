//
//  AppDelegate.swift
//  sferaTZ
//
//  Created by Serega Kushnarev on 28.09.2021.
//

import UIKit

// MARK: - AppDelegate

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Public property
    
    var window: UIWindow?
    
    // MARK: - Public methods
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let userInformationController = TimerController()
        let navigationController = UINavigationController(rootViewController: userInformationController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

