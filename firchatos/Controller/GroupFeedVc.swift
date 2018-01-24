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
    
    
    //vars
    var group: Group?
    //Functions
    
    func initGroupData(forGroup group: Group) {
        self.group = group
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        sendButtonView.bindToKeyboard()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupTitle.text = group?.groupTitle
        DataService.instance.getEmailFor(group: group!) { (returnedEmails) in
            self.members.text = returnedEmails.joined(separator: ", ")
        }
        
        
    }
    
    //Actions
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
