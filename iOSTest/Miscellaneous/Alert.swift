//
//  Alert.swift
//  iOSTest
//
//  Created by Apple on 07/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//
import Foundation
import UIKit

class Alert {
    
    // can use static or class type method
    
    static func showBasic(title: String, message: String, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true)
    }
}
