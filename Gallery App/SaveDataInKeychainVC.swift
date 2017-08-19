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
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
