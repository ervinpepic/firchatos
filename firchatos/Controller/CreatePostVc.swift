//
//  CreatePostVc.swift
//  firchatos
//
//  Created by Ervin on 18/01/2018.
//  Copyright © 2018 Ervin Pepic. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVc: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var textField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.delegate = self
        sendButton.bindToKeyboard()

        
    }
//Actions
    @IBAction func sendbuttopressed(_ sender: Any) {
        if textField.text != nil && textField.text != "Say something" {
            sendButton.isEnabled = false
            DataService.instance.uploadPost(withMessage: textField.text, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: nil, sendComplete: { (isComplete) in
                if isComplete {
                    self.sendButton.isEnabled = true
                    self.dismiss(animated: true, completion: nil)
                    print("success!!")
                } else {
                    self.sendButton.isEnabled = true
                    print("There was an error")
                }
            })
        }
        
    }
   
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension CreatePostVc: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textField.text = ""
    }
}
