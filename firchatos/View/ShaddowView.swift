//
//  ShaddowView.swift
//  firchatos
//
//  Created by Ervin on 16/01/2018.
//  Copyright © 2018 Ervin Pepic. All rights reserved.
//

import UIKit

class ShaddowView: UIView {

    //function
    
    override func awakeFromNib() {
        self.layer.shadowOpacity = 0.73
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        super.awakeFromNib()
    }
 

}
