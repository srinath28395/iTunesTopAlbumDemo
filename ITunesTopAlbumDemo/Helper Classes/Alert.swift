//
//  Alert.swift
//  TopAlbums
//
//  Created by Shreenath on 05/07/20.
//

import Foundation
import UIKit

let appTitle = Bundle.appName()

class Alert {
    
    class func showNormalAlertWith( title: String = appTitle, message: String){
        let alertcontroller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertcontroller.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            guard let topController = UIApplication.topViewController() else { return }
            topController.present(alertcontroller, animated: true, completion: nil)
        }
    }
    
}
