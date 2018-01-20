//
//  UserCell.swift
//  firchatos
//
//  Created by Ervin on 19/01/2018.
//  Copyright © 2018 Ervin Pepic. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    //Outlets
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    
    //variables
    var showing = false
    //function
    
    func configureCell(profileImage image: UIImage, email: String, isSelected: Bool) {
        self.profileImage.image = image
        self.emailLabel.text = email
        
        if isSelected {
            self.checkImage.isHidden = false
        } else {
            self.checkImage.isHidden = true
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            if showing == false {
                checkImage.isHidden = false
                showing = true
            } else {
                checkImage.isHidden = true
                showing = false
            }
            
        }
    }

}
