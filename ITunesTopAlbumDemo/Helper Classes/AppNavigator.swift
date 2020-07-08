//
//  AppNavigator.swift
//  TopAlbums
//
//  Created by Chanappa on 21/10/19.
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
