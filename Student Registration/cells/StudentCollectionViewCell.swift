//
//  StudentCollectionViewCell.swift
//  Student Registration
//
//  Created by Shwe Yi Tun on 12/1/18.
//  Copyright © 2018 Shwe Yi Tun. All rights reserved.
//

import UIKit

class StudentCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var nrc: UILabel!
    
    @IBOutlet weak var fathername: UILabel!
    
    
    @IBOutlet weak var dob: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let imageViewWidthConstraint = NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 130)
        let imageViewHeightConstraint = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 130)

        imageView.addConstraints([imageViewWidthConstraint, imageViewHeightConstraint])
        
        stackView.distribution = .fillProportionally


    }
    

}
