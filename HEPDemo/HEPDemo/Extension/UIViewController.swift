//
//  UIViewController.swift
//  HEPDemo
//
//  Created by Newton Foundation on 2019/6/21.
//  Copyright © 2019 Newton Foundation. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// Show loading hud
    func displayLoading(
        text: String = String(format: NSLocalizedString("loading.dots", value: "Loading %@", comment: ""), "..."),
        animated: Bool = true
        ) {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: animated)
        hud.label.text = text
    }
    
    /// Hide loading hud
    func hideLoading(animated: Bool = true) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
            MBProgressHUD.hide(for: self.view, animated: animated)
        }
    }
    
    /// Show alert
    func showAlert(title: String, message: String) {
        let controller = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertController.Style.alert
        )
        controller.addAction(UIAlertAction(title: NSLocalizedString("OK", value: "OK", comment: ""), style: .default))
        self.present(controller, animated: true, completion: {})
    }
}
