//
//  SettingsViewController.swift
//  raspVega
//
//  Created by Peter Kvasnikov on 23.11.2020.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        return tableView
    }()
    
    let cellId1 = "cellId1"
    let cellId2 = "cellId2"
    var currentSeceltedGroupName = ""
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1

        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId1, for: indexPath) as! GroupTableViewCell
            cell.accessoryType = UITableViewCell.AccessoryType.none
            cell.groupLabel.text = currentSeceltedGroupName
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId2, for: indexPath) as! GroupChangeTableViewCell
            cell.textLabel!.text = "📘 Изменить группу"
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 100
        } else {
            return 50
        }
    }
    
    func  tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1{
            let controller = GreetingViewController()
            controller.refreshDocumentsDelegate = self
            let navigationController = UINavigationController(rootViewController: controller)

            present(navigationController, animated: true, completion: nil)
        }
    }

    
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        let selectedGroup = defaults.object(forKey: "selectedGroup") as? [String]
        currentSeceltedGroupName = (selectedGroup?[1])!
        
        setupTableView()
        tableView.reloadData()
        

 
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.rowHeight = 60.0
        tableView.register(GroupTableViewCell.self, forCellReuseIdentifier: cellId1)
        tableView.register(GroupChangeTableViewCell.self, forCellReuseIdentifier: cellId2)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
                                        
        ])
        

    }
    

}

extension SettingsViewController: RefreshSettingsViewController{
    func refreshCurrentGroupName(group: String) {
        self.currentSeceltedGroupName = group
        tableView.reloadData()
        print(currentSeceltedGroupName)
    }
    
    
    
}
