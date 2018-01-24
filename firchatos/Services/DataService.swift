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
            REF_GROUPS.child(groupKey!).child("messages").childByAutoId().updateChildValues(["content": message, "senderId": uid])
            sendComplete(true)
        } else {
            REF_FEED.childByAutoId().updateChildValues(["content": message, "senderId": uid])
            sendComplete(true)
        }
    }
    
    func getFeedMessages(handler: @escaping (_ messages: [Messages]) -> ()) {
        var messageArray = [Messages]()
        REF_FEED.observeSingleEvent(of: .value) { (feedMessageSnapshot) in
            guard let feedMessageSnapshot = feedMessageSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for message in feedMessageSnapshot {
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderId = message.childSnapshot(forPath: "senderId").value as! String
                let message = Messages(content: content, senderId: senderId)
                messageArray.append(message)
            }
            handler(messageArray)
        }
    }
    
    
    func getAllMessagesFor(desiredGroup: Group, handler: @escaping(_ messagesArray: [Messages]) -> ()) {
            var groupMessageArray = [Messages]()
            REF_GROUPS.child(desiredGroup.key).child("messages").observeSingleEvent(of: .value) { (groupMessageSnapshot) in
                guard let groupMessageSnapshot = groupMessageSnapshot.children.allObjects as? [DataSnapshot] else { return }
                for groupMessage in groupMessageSnapshot {
                    let content = groupMessage.childSnapshot(forPath: "content").value as! String
                    let senderId = groupMessage.childSnapshot(forPath: "senderId").value as! String
                    let groupMessage = Messages(content: content, senderId: senderId)
                    groupMessageArray.append(groupMessage)
                }
                handler(groupMessageArray)
                
               
            }
        
    }
    
    func getUsername(forUid uid: String, handler: @escaping (_ username: String) -> ()) {
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshoot) in
            guard let userSnapshoot = userSnapshoot.children.allObjects as? [DataSnapshot] else { return }
            
            for user in userSnapshoot {
                if user.key == uid {
                    handler(user.childSnapshot(forPath: "email").value as! String)
                }
            }
        }
    }
    
    func getEmail(forsSearchQeury q: String, handler: @escaping (_ emailArray: [String]) -> ()) {
        var emailArray = [String]()
        REF_USERS.observe(.value) { (userSnapshoot) in
            guard let userSnapshoot = userSnapshoot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshoot {
                let email = user.childSnapshot(forPath: "email").value as! String
                
                if email.contains(q) == true && email != Auth.auth().currentUser?.email {
                    emailArray.append(email)
                }
            }
            handler(emailArray)
        }
    }
    
    func getId(forUsernames usernames: [String], handler: @escaping (_ uidArray: [String]) -> ()) {
        REF_USERS.observeSingleEvent(of: .value) { (korisnikSnapshoot) in
            var idArray = [String]()
            guard let userSnapshoot = korisnikSnapshoot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshoot {
                let email = user.childSnapshot(forPath: "email").value as! String
                if usernames.contains(email) {
                    idArray.append(user.key)
                }
            }
            handler(idArray)
        }
    }
    func createGroup(withTitle title: String, andDescription description: String, forUserIds ids: [String], handler: @escaping (_ groupCreated: Bool) -> ()) {
        REF_GROUPS.childByAutoId().updateChildValues(["title": title, "description": description, "members": ids])
        handler(true)
    }
    
    func getEmailFor(group: Group, handler: @escaping (_ emailArray: [String]) -> ()) {
        var emailArray = [String]()
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshoot) in
            guard let userSnapshoot = userSnapshoot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshoot {
                if group.members.contains(user.key) {
                    let email = user.childSnapshot(forPath: "email").value as! String
                    emailArray.append(email)
                }
            }
            handler(emailArray)
        }
    }
    
    func getAllGroups(handler: @escaping (_ groupsArray: [Group]) -> ()) {
        var groupsArray = [Group]()
        REF_GROUPS.observeSingleEvent(of: .value) { (groupSnapshoot) in
            guard let groupSnapshoot = groupSnapshoot.children.allObjects as? [DataSnapshot] else { return }
            for group in groupSnapshoot {
                let memberArray = group.childSnapshot(forPath: "members").value as! [String]
                if memberArray.contains((Auth.auth().currentUser?.uid)!) {
                    let title = group.childSnapshot(forPath: "title").value as! String
                    let description = group.childSnapshot(forPath: "description").value as! String
                    
                    let group = Group(title: title, description: description, key: group.key, members: memberArray, memberCount: memberArray.count)
                    groupsArray.append(group)
            }
        }
            handler(groupsArray)
    }
    
    
}
    
}
