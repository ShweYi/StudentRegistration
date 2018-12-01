//
//  SignUpViewController.swift
//  Student Registration
//
//  Created by Shwe Yi Tun on 12/1/18.
//  Copyright © 2018 Shwe Yi Tun. All rights reserved.
//

import UIKit
import SDWebImage

class SignUpViewController: BaseViewController {

    
    @IBOutlet weak var circularImageView: UIImageView!
    
    @IBOutlet weak var nameTextField: BorderTextField!
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var nrcTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var fathername: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var datePicker : UIDatePicker?
    var name : String = ""
    var email : String = ""
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.endEditing(true)
        
        circularImageView.layer.cornerRadius = circularImageView.frame.size.width/2
        circularImageView.clipsToBounds = true
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(SignUpViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        dateTextField.inputView = datePicker
        UserDefaults.standard.set("", forKey: "url")
        nameTextField.text = name
        emailTextField.text = email
        
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateTextField.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
        
    }
    
    @IBAction func backHome(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func goSignUp(_ sender: CustomButton) {
        if nameTextField.text!.isEmpty {
            showAlertDialog(inputMessage: "Name is Empty!")
            return
        } else if phoneTextField.text!.isEmpty {
            showAlertDialog(inputMessage: "Phone no is Empty!")
            return
        } else if passwordTextField.text!.isEmpty {
            showAlertDialog(inputMessage: "Password is Empty!")
            return
        } else if nrcTextField.text!.isEmpty {
            showAlertDialog(inputMessage: "Phone no is Empty!")
            return
        } else if dateTextField.text!.isEmpty {
            showAlertDialog(inputMessage: "Date of Birth is Empty!")
            return
        } else if emailTextField.text!.isEmpty {
            showAlertDialog(inputMessage: "Email Address is Empty!")
            return
        } else if fathername.text!.isEmpty {
            showAlertDialog(inputMessage: "Father Name is Empty!")
            return
        } else {
            let user = StudentVO()
            user.username = nameTextField.text!
            user.phone = phoneTextField.text!
            user.email = emailTextField.text!
            user.password = passwordTextField.text!
            user.nrc = nrcTextField.text!
            user.dob = dateTextField.text!
            user.fathername = fathername.text!
            user.image = UserDefaults.standard.string(forKey: "url")
            
            DataModel.shared.register(user: user, success: {
                UserDefaults.standard.set("", forKey: "url")
                self.showAlertDialog(inputMessage: "Account Created")
            })
            
        }
    }
    
    @IBAction func uploadImage(_ sender: UIBarButtonItem) {
        self.chooseUpload(sender, imagePickerControllerDelegate: self)
    }
    

}

extension SignUpViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.dismiss(animated: true, completion: nil)
        
        if let pickedImage = info[.editedImage] as? UIImage {
            
        DataModel.shared.uploadImage(data: pickedImage.pngData(), success: { (url) in
            
            UserDefaults.standard.set(url, forKey: "url")
            self.circularImageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "profile"))
            
            }) {
                self.showAlertDialog(inputMessage: "Error.")
            }
            
        }
        
    }
}
