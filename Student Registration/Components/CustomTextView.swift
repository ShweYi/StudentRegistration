//
//  CustomTextView.swift
//  Student Registration
//
//  Created by Shwe Yi Tun on 12/1/18.
//  Copyright © 2018 Shwe Yi Tun. All rights reserved.
//

import UIKit

class CustomTextView: UITextView {
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 1.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        clipsToBounds = true
    }
    
}

