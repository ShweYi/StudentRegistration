//
//  Extensions.swift
//  Student Registration
//
//  Created by Shwe Yi Tun on 11/30/18.
//  Copyright © 2018 Shwe Yi Tun. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
}

extension UIViewController {
    
    public func showAlertDialog(inputTitle: String = "Message", inputMessage: String, alertActionTitle: String = "OK!") {
        let alert = UIAlertController(title: inputTitle, message: inputMessage, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: alertActionTitle, style: UIAlertAction.Style.default)
        {
            (UIAlertAction) -> Void in
        }
        alert.addAction(alertAction)
        present(alert, animated: true)
        {
            () -> Void in
        }
    }
    
}

