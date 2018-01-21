//
//  GroupCell.swift
//  firchatos
//
//  Created by Ervin on 21/01/2018.
//  Copyright © 2018 Ervin Pepic. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var groupTitle: UILabel!
    @IBOutlet weak var groupDescription: UILabel!
    @IBOutlet weak var memberCount: UILabel!
    
    
    func configureCell(title: String, description: String, memberCount: Int) {
        self.groupTitle.text = title
        self.groupDescription.text = description
        self.memberCount.text = "\(memberCount) members"
    }
}
