//
//  SaveDataInKeychainVC.swift
//  Gallery App
//
//  Created by Apple on 8/19/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit


class SaveDataInKeychainVC: UIViewController {

    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    @IBAction func saveDataInKeychain(_ sender: UIButton) {
        
        if let usrname = usernameTF.text, let pswd = passwordTF.text {
            let saveUsername: Bool = KeychainWrapper.standard.set(usrname, forKey: "username")
            let savepassword: Bool = KeychainWrapper.standard.set(pswd, forKey: "password")
            print("Save was successful: \(saveUsername), \(savepassword)")
        }
    }
    
    @IBAction func retrievePasswordButtonTapped(_ sender: UIButton) {
        var alertMsg: String?
        if let retrievedUsername = KeychainWrapper.standard.string(forKey: "username") ,let retrievedPassword = KeychainWrapper.standard.string(forKey: "password") {
            alertMsg = "Retrieved Username is: \(retrievedUsername) \n Retrieved password is: \(retrievedPassword)"
        }
        else{
            alertMsg = "Oops! Got nothing. Please save data in keychain."
        }
        let alert = UIAlertController(title: "Keychain Data", message: alertMsg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
