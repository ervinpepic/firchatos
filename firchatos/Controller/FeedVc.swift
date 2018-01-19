//
//  FirstViewController.swift
//  firchatos
//
//  Created by Ervin on 15/01/2018.
//  Copyright © 2018 Ervin Pepic. All rights reserved.
//

import UIKit

class FeedVc: UIViewController {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // variables
    var messageArray = [Messages]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.getFeedMessages { (returnedMessagesArray) in
            self.messageArray = returnedMessagesArray.reversed()
            self.tableView.reloadData()
        }
    }
}

extension FeedVc: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as? FeedCell else { return UITableViewCell() }
        let image = UIImage(named: "defaultProfileImage")
        
        let message = messageArray[indexPath.row]
        
        DataService.instance.getUsername(forUid: message.senderId) { (returnedUsername) in
            cell.configureCell(profileImage: image!, email: returnedUsername, content: message.content)
        }
        return cell
    }
}
