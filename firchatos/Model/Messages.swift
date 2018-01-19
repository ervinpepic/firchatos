//
//  Messages.swift
//  firchatos
//
//  Created by Ervin on 19/01/2018.
//  Copyright © 2018 Ervin Pepic. All rights reserved.
//

import Foundation

class Messages {
    
    //variables private and public
    
    private var _content: String
    private var _senderId: String
    
    public var content: String {
        return _content
    }
    
    public var senderId: String {
        return _senderId
    }
    //class init
    init(content: String, senderId: String) {
        self._content = content
        self._senderId = senderId
    }
}
