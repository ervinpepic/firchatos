//
//  GroupFeedVc.swift
//  firchatos
//
//  Created by Ervin on 22/01/2018.
//  Copyright © 2018 Ervin Pepic. All rights reserved.
//

import UIKit

class GroupFeedVc: UIViewController {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var groupTitle: UILabel!
    @IBOutlet weak var members: UILabel!
    @IBOutlet weak var sendButtonView: UIView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageText: InsetTextField!
    
    //Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        sendButtonView.bindToKeyboard()
        
    }
    
    //Actions
    
    @IBAction func sendButtonPressed(_ sender: Any) {
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
