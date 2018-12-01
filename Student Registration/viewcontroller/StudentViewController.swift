//
//  StudentViewController.swift
//  Student Registration
//
//  Created by Shwe Yi Tun on 12/1/18.
//  Copyright © 2018 Shwe Yi Tun. All rights reserved.
//

import UIKit

class StudentViewController: BaseViewController {
    
    @IBOutlet weak var StudentCollectionView: UICollectionView!
    
    var studentList : [StudentVO] = []
    
    @IBAction func logout(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StudentCollectionView.dataSource = self
        StudentCollectionView.delegate = self
        CellRegisterUtil.cellRegister(nibName: "StudentCollectionViewCell", collectionView: StudentCollectionView)
        
        getAllStudents()
        
    }
    func getAllStudents() {
        
        DataModel.shared.getStudent(success: { (data) in
            
            self.studentList.removeAll()
            self.studentList.append(contentsOf: data)
            self.StudentCollectionView.reloadData()
            
        }, failure: {
            
        })
        
    }

}

extension StudentViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.studentList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StudentCollectionViewCell", for: indexPath) as! StudentCollectionViewCell
        let student = self.studentList[indexPath.row]
        
        cell.name.text = student.username ?? "Unknown"
        cell.nrc.text = student.nrc ?? "Unknown"
        cell.fathername.text = student.fathername ?? "Unknown"
        cell.dob.text = student.dob ?? "Unknown"
        cell.imageView.sd_setImage(with: URL(string: student.image ?? "https://fedspendingtransparency.github.io/assets/img/user_personas/repurposer_mug.jpg"), placeholderImage: UIImage(named: "profile"))
    
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

extension StudentViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(indexPath.row)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 190)
    }
}


