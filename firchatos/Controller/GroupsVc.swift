//
//  SecondViewController.swift
//  firchatos
//
//  Created by Ervin on 15/01/2018.
//  Copyright © 2018 Ervin Pepic. All rights reserved.
//

import UIKit

class GroupsVc: UIViewController {

    @IBOutlet weak var groupsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupsTableView.delegate = self
        groupsTableView.dataSource = self
    }

    
    
    

}

extension GroupsVc: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = groupsTableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? GroupCell else { return UITableViewCell() }
        cell.configureCell(title: "Nerd Herd", description: "ttttt", memberCount: 3)
        return cell
    }
}
