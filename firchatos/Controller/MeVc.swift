//
//  MeVc.swift
//  firchatos
//
//  Created by Ervin on 17/01/2018.
//  Copyright © 2018 Ervin Pepic. All rights reserved.
//

import UIKit
import Firebase

class MeVc: UIViewController {

    // Outlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailDisplay: UILabel!
    @IBOutlet weak var tableViewDisplay: UITableView!
    
    //functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.emailDisplay.text = Auth.auth().currentUser?.email
    }
    
    //Actions
    @IBAction func signOutButton(_ sender: Any) {
        let logoutPopUp = UIAlertController(title: "Logout?", message: "Logout now?", preferredStyle: .actionSheet)
        
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) { (buttonTapped) in
            do {
                try Auth.auth().signOut()
                let authVC = self.storyboard?.instantiateViewController(withIdentifier: "AuthVc") as? AuthVc
                self.present(authVC!, animated: true, completion: nil)
            } catch {
                print(error)
            }
        }
        
        logoutPopUp.addAction(logoutAction)
        present(logoutPopUp, animated: true, completion: nil)
    }
}
