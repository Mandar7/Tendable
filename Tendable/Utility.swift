//
//  Utility.swift
//  Tendable
//
//  Created by Choudhary, Mandar on 15/06/24.
//

import UIKit

extension UIViewController {
    
    func presentAlert(title: String, message: String, actionTitle: String = "OK", completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: actionTitle, style: .default) { _ in
            completion?()
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
