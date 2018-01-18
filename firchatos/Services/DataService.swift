//
//  DataService.swift
//  firchatos
//
//  Created by Ervin on 15/01/2018.
//  Copyright © 2018 Ervin Pepic. All rights reserved.
//

import Foundation
import Firebase

//Constants

let DB_BASE = Database.database().reference()


class DataService {
    
    //class instance through all lifecycle app
    static let instance = DataService()
    
    
    //Variables
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_FEED = DB_BASE.child("feed")
    
    var REF_BASE: DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference {
        return _REF_USERS
    }
    
    var REF_GROUPS: DatabaseReference {
        return _REF_GROUPS
    }
    
    var REF_FEED: DatabaseReference {
        return _REF_FEED
    }
    
    //Functions
    
    func createDBUser(uid: String, userData: Dictionary<String, Any>) {
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func uploadPost(withMessage message: String, forUID uid: String, withGroupKey groupKey: String?,sendComplete: @escaping (_ status: Bool) -> ()) {
        
        if groupKey != nil {
            //send to groups referencce
        } else {
            REF_FEED.childByAutoId().updateChildValues(["content": message, "senderId": uid])
            sendComplete(true)
        }
    }
}
