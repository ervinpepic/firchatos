//
//  AuthVc.swift
//  firchatos
//
//  Created by Ervin on 16/01/2018.
//  Copyright © 2018 Ervin Pepic. All rights reserved.
//

import UIKit
import Firebase

class AuthVc: UIViewController {

    //Outlets
    
    //Constants
    
    //Functions
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if Auth.auth().currentUser != nil {
            dismiss(animated: true, completion: nil)
        }
    }


    // Actions
    @IBAction func signInWithEmail(_ sender: Any) {
        let loginVc = storyboard?.instantiateViewController(withIdentifier: "LoginVc")
        present(loginVc!, animated: true, completion: nil)
    }
    
    @IBAction func singInWithGoogle(_ sender: Any) {
    }
    
    @IBAction func signInWithFacebook(_ sender: Any) {
    }
    
}
