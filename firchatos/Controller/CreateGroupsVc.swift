//
//  CreateGroupsVc.swift
//  firchatos
//
//  Created by Ervin on 19/01/2018.
//  Copyright © 2018 Ervin Pepic. All rights reserved.
//

import UIKit

class CreateGroupsVc: UIViewController {

    //Outlets
    @IBOutlet weak var titleTextField: InsetTextField!
    @IBOutlet weak var descriptionTextField: InsetTextField!
    @IBOutlet weak var membersGroupField: InsetTextField!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var groupMemberLabel: UILabel!
    
    //Arrays
    var emailArray = [String]()
    var choosenUserArray = [String]()
    
    //Functions
    @objc func textFieldDidChange() {
        if membersGroupField.text == "" {
            emailArray = []
            tableView.reloadData()
        } else {
            DataService.instance.getEmail(forsSearchQeury: membersGroupField.text!, handler: { (returnedEmailArray) in
                self.emailArray = returnedEmailArray
                self.tableView.reloadData()
            })
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        membersGroupField.delegate = self
        membersGroupField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doneBtn.isHidden = true
    }
    
    //Actions
    @IBAction func doneBtn(_ sender: Any) {
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }


}

//Extensions for CreateGroupsVc

extension CreateGroupsVc: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else { return UITableViewCell() }
        let profileImage = UIImage(named: "defaultProfileImage")
        
        if choosenUserArray.contains(emailArray[indexPath.row]) {
            cell.configureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: true)
        } else {
            cell.configureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: false)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return }
        if !choosenUserArray.contains(cell.emailLabel.text!) {
            choosenUserArray.append(cell.emailLabel.text!)
            groupMemberLabel.text = choosenUserArray.joined(separator: ", ")
            doneBtn.isHidden = false
        } else {
            choosenUserArray = choosenUserArray.filter({ $0 != cell.emailLabel.text! })
            if choosenUserArray.count >= 1 {
                groupMemberLabel.text = choosenUserArray.joined(separator: ", ")
        } else {
            groupMemberLabel.text = "Add Participants"
            doneBtn.isHidden = true
            }
        }
    }
}

extension CreateGroupsVc: UITextFieldDelegate {
    
}
