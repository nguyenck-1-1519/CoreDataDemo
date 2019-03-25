//
//  Alert.swift
//  CoreDataDemo
//
//  Created by can.khac.nguyen on 3/22/19.
//  Copyright © 2019 can.khac.nguyen. All rights reserved.
//

import UIKit
typealias Action = (title: String?, handler: (() -> Void)?)
private let kAlertWindowLevel: CGFloat = 0.2

class Alert {

    private static var window: UIWindow = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.windowLevel = UIWindow.Level.normal + kAlertWindowLevel
        window.isOpaque = false
        window.rootViewController = ViewController()
        return window
    }()

    static func showErrorAlert(withMessage message: String, okHandle: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            window.isHidden = true
            okHandle?()
        }
        alertController.addAction(okAction)
        DispatchQueue.main.async {
            window.isHidden = false
            window.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }

    static func hiddenWindow() {
        window.isHidden = true
    }
}
