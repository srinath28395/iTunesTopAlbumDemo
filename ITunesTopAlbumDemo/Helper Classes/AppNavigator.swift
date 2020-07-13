//
//  AppNavigator.swift
//  TopAlbums
//
//  Created by Shreenath on 05/07/20.
//

import Foundation
import UIKit

class AppNavigator {
    static let sharedInstance = AppNavigator()
    
    lazy var navigationController: UINavigationController = {
        let navController = UINavigationController()
        return navController
    }()
    
    
    func getInitialNavigationController() -> UINavigationController {
        return navigationController
    }
    
    func setRootController(onRootWindow window: UIWindow) {
        let topAlbumController = TopAlbumsListViewController()
        navigationController.viewControllers = [topAlbumController]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
