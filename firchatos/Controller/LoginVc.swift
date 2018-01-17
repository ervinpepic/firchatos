//
//  LoginVc.swift
//  firchatos
//
//  Created by Ervin on 16/01/2018.
//  Copyright © 2018 Ervin Pepic. All rights reserved.
//

import UIKit

class LoginVc: UIViewController {
    
//Outlets
    @IBOutlet weak var emailField: InsetTextField!
    @IBOutlet weak var passwordField: InsetTextField!
    //Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.delegate = self
        passwordField.delegate = self

    
    }
    //Actions
    
    @IBAction func SignIntButton(_ sender: Any) {
        if emailField.text != nil && passwordField.text != nil {
            AuthService.instance.loginUser(withEmail: emailField.text!, andPassword: passwordField.text!, loginComplete: { (success, loginError) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print(String(describing: loginError?.localizedDescription))
                }
                AuthService.instance.registerUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!, userCreationComplete: { (success, registerError) in
                    if success {
                        AuthService.instance.loginUser(withEmail: self.emailField.text!, andPassword: self.passwordField.text!, loginComplete: { (sucess, nil) in
                            self.dismiss(animated: true, completion: nil)
                            print("Successefully registered user!")
                        })
                    } else {
                        print(String(describing: registerError?.localizedDescription))
                    }
                })
            })
        }
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
}
// extensions
extension LoginVc: UITextFieldDelegate {
    
}
