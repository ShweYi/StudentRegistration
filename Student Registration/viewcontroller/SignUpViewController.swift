//
//  SignUpViewController.swift
//  Student Registration
//
//  Created by Shwe Yi Tun on 12/1/18.
//  Copyright © 2018 Shwe Yi Tun. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var circularImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        circularImageView.layer.cornerRadius = circularImageView.frame.size.width/2
        circularImageView.clipsToBounds = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
