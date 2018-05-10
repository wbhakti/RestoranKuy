//
//  LoginViewController.swift
//  RestoranKuy
//
//  Created by wisnu bhakti on 5/10/18.
//  Copyright © 2018 wisnu bhakti. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,LoginDelegate {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var errorLBL: UILabel!
    @IBOutlet weak var loginBTN: UIButton!
    
    private let loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginViewModel.delegate = self
        loginBTN.isEnabled      = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    @IBAction func loginAction(_ sender: Any) {
        guard let email = emailTF.text, let password = passwordTF.text else {
            return
        }
        
        if (email.count == 0 || password.count == 0){
            return
        }
        
        loginBTN.isEnabled  = false
        errorLBL.text       = ""
        
        loginViewModel.login(email: email, password: password)
    }
    
    
    func loginResponse(_ data: NSObject?, _ error: Error?) {
        loginBTN.isEnabled  = true
        
        if data != nil {
            self.dismiss(animated: true, completion: nil)
        } else {
            guard let err = error else { return }
            
            errorLBL.text = err.localizedDescription
            print("Error : ", err.localizedDescription)
        }
    }
    
    
}
