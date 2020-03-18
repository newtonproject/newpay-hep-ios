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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
            self.present(controller, animated: true, completion: {})
        }
    }
    
    public func presentCopy (_ input: String, sender: UIView) {
        self.present(makeAlertSheet(input, sender: sender), animated: true, completion: nil)
    }
    
    private func makeAlertSheet(_ input: String, sender: UIView) -> UIAlertController {
        let alertController = UIAlertController(
            title: nil,
            message: input,
            preferredStyle: .actionSheet
        )
        let copyAction = UIAlertAction(title: NSLocalizedString("alert.button.title.copy", value: "Copy", comment: ""), style: .default) { _ in
            UIPasteboard.general.string = input
            alertController.dismiss(animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: NSLocalizedString("alert.button.title.cancel", value: "Cancel", comment: ""), style: .cancel) { _ in
        }
        
        alertController.addAction(copyAction)
        alertController.addAction(cancelAction)
        
        if let popoverPresentationController = alertController.popoverPresentationController {
            popoverPresentationController.sourceView = sender
            popoverPresentationController.sourceRect = sender.centerRect
        }
        
        return alertController
    }
}
