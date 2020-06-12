//
//  UIViewControllerExt.swift
//  MobileDataUsage
//
//  Created by Andrew Khoo on 12/6/20.
//  Copyright © 2020 Andrew Khoo. All rights reserved.
//

import UIKit

typealias alertOkCompletionBlock = () -> Void
typealias alertCancelCompletionBlock = () -> Void

extension UIViewController {
    func showAlert(title: String = "Error",
                   message: String,
                   actionTitle: String = "Retry",
                   actionCompletion: alertOkCompletionBlock? = nil,
                   cancelTitle: String = "Cancel",
                   cancelCompletion: alertCancelCompletionBlock? = nil) {
        
        let alertCtrl = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // Action
        if actionTitle.count > 0 {
            let action = UIAlertAction(title: actionTitle, style: .default) { (alertAction) in
                
                if let _actionCompletion = actionCompletion {
                    _actionCompletion()
                }
            }
            
            alertCtrl.addAction(action)
        }
        
        // Cancel action
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel) { (alertAction) in
            
            if let _cancelCompletion = cancelCompletion {
                _cancelCompletion()
            }
        }
        
        alertCtrl.addAction(cancelAction)
        
        self.present(alertCtrl, animated: true, completion: nil)
    }
}
