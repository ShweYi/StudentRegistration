//
//  ViewController.swift
//  Student Registration
//
//  Created by Shwe Yi Tun on 11/30/18.
//  Copyright © 2018 Shwe Yi Tun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblGoogle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let fullString = NSMutableAttributedString(string: "")
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "google")
        attachment.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
        let imageString = NSAttributedString(attachment: attachment)
        fullString.append(imageString)
        fullString.append(NSAttributedString(string: " Continue with Google"))
        lblGoogle.attributedText = fullString
    }


}



