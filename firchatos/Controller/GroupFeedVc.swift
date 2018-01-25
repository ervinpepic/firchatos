//
//  GroupFeedVc.swift
//  firchatos
//
//  Created by Ervin on 22/01/2018.
//  Copyright © 2018 Ervin Pepic. All rights reserved.
//

import UIKit
import Firebase

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
    var groupMessages = [Messages]()
    //Functions
    
    func initGroupData(forGroup group: Group) {
        self.group = group
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        sendButtonView.bindToKeyboard()
        tableView.delegate = self
        tableView.dataSource = self
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupTitle.text = group?.groupTitle
        DataService.instance.getEmailFor(group: group!) { (returnedEmails) in
            self.members.text = returnedEmails.joined(separator: ", ")
        }
        
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllMessagesFor(desiredGroup: self.group!, handler: { (returnedGroupMessages) in
                self.groupMessages = returnedGroupMessages
                self.tableView.reloadData()
                
                if self.groupMessages.count > 0 {
                    self.tableView.scrollToRow(at: IndexPath(row: self.groupMessages.count - 1, section: 0), at: .none, animated: true)
                }
            })
        }
    }
    
    //Actions
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        if messageText.text != "" {
            messageText.isEnabled = false
            sendButton.isEnabled = false
            DataService.instance.uploadPost(withMessage: messageText.text!, forUID: Auth.auth().currentUser!.uid, withGroupKey: group?.key, sendComplete: { (complete) in
                if complete {
                    self.messageText.text = ""
                    self.messageText.isEnabled = true
                    self.sendButton.isEnabled = true
                }
            })
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismisDetail()
    }
    
}

extension GroupFeedVc: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupfeedCell", for: indexPath) as? GroupFeedCell else { return UITableViewCell() }
        let message = groupMessages[indexPath.row]
        DataService.instance.getUsername(forUid: message.senderId) { (returnedEmail) in
            cell.configureCell(profileImage: UIImage(named: "defaultProfileImage")!, email: returnedEmail, content: message.content)
            
        }
        
        return cell
    }
}

