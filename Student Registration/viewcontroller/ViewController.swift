//
//  ViewController.swift
//  Student Registration
//
//  Created by Shwe Yi Tun on 11/30/18.
//  Copyright © 2018 Shwe Yi Tun. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: BaseViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if (error) != nil {
            print("An error occured during Google Authentication")
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                self.showAlertDialog(inputMessage: error.localizedDescription)
                return
            }
            var mainView: UIStoryboard!
            mainView = UIStoryboard(name: "Main", bundle: nil)
            let navigationController = mainView.instantiateViewController(withIdentifier: "SignUpViewController") as! UINavigationController
            
            let vc = navigationController.viewControllers[0] as! SignUpViewController
            vc.name = user.profile.name
            vc.email = user.profile.email
            self.present(navigationController, animated: true, completion: nil)
            
        }
        
    }
    
    func sign(_ signIn: GIDSignIn?, present viewController: UIViewController?) {
        
        if let aController = viewController {
            present(aController, animated: true) {() -> Void in }
        }
    }
    func sign(_ signIn: GIDSignIn?, dismiss viewController: UIViewController?) {
        dismiss(animated: true) {() -> Void in }
    }
    

    @IBOutlet weak var lblGoogle: UILabel!
    
    @IBOutlet weak var lblFacebook: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var pwdTextField: UITextField!
    
    @IBOutlet weak var lblSignUp: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        lblSignUp.isUserInteractionEnabled = true
        lblSignUp.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onClickSignUp)))
        lblGoogle.isUserInteractionEnabled = true
        lblGoogle.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onClickGoogle)))
        
        lblFacebook.isUserInteractionEnabled = true
        lblFacebook.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.onClickFacebook)))
        
    }
    
    @IBAction func btnSignIn(_ sender: CustomButton) {
        
        DataModel.shared.login(email: emailTextField.text!, password: pwdTextField.text!, success: {
            
           let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let nc = storyBoard.instantiateViewController(withIdentifier: "StudentViewController") as! UINavigationController
            self.present(nc, animated: true, completion: nil)
            
        }) {
            self.showAlertDialog(inputMessage: "User does not exist. Please Register.")
        }
        
        
        
    }
    @objc func onClickGoogle(sender:UILabel){
        
        GIDSignIn.sharedInstance().signIn()
        
    }
    
    @objc func onClickFacebook(sender:UILabel){
        facebookLogin()
    }
    
    func facebookLogin() {
        
        
        let login = FBSDKLoginManager()
        login.logIn(withReadPermissions: ["email", "public_profile"], from: self, handler: { result, error in
            if error != nil {
                print("Process error")
            }else {
                let fbLoginResult: FBSDKLoginManagerLoginResult  = result!
                
                if( result?.isCancelled)!{
                    return }
                
                
                if(fbLoginResult .grantedPermissions.contains("email")){
                    self.getFbId()
                }
            }
            
//            guard let accessToken = FBSDKAccessToken.current() else {
//                print("Failed to get access token")
//                return
//            }
            
//            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
//
//            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
//                if let error = error {
//                    self.showAlertDialog(inputMessage: error.localizedDescription)
//                    return
//                }
//            }
//
            
        })
        
    }
    
    func getFbId(){
        if(FBSDKAccessToken.current() != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id,name , first_name, last_name , email,picture.type(large)"]).start(completionHandler: { (connection, result, error) in
                guard let Info = result as? [String: Any] else { return }
                if let imageURL = ((Info["picture"] as? [String: Any])?["data"] as? [String: Any])?["url"] as? String {
                    //Download image from imageURL
                    print(imageURL)
                }
                print(Info)
                var mainView: UIStoryboard!
                mainView = UIStoryboard(name: "Main", bundle: nil)
                let navigationController = mainView.instantiateViewController(withIdentifier: "SignUpViewController") as! UINavigationController
                let vc = navigationController.viewControllers[0] as! SignUpViewController
                vc.name = Info["name"] as? String ?? ""
                vc.email = Info["email"] as? String ?? ""
                self.present(navigationController, animated: true, completion: nil)
                
                if(error == nil){
                    print("result")
                }
                
            })
        }
    }
    
    @objc func onClickSignUp(sender:UILabel){
        var mainView: UIStoryboard!
        mainView = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = mainView.instantiateViewController(withIdentifier: "SignUpViewController") as! UINavigationController
        self.present(navigationController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let fullString = NSMutableAttributedString(string: "Continue with ")
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "google")
        attachment.bounds = CGRect(x: 0, y: -5, width: 25, height: 25)
        let imageString = NSAttributedString(attachment: attachment)
        fullString.append(imageString)
        fullString.append(NSAttributedString(string: "oogle"))
        lblGoogle.attributedText = fullString
    }


}



