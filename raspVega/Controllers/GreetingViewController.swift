//
//  GreetingViewController.swift
//  raspVega
//
//  Created by Peter Kvasnikov on 23.11.2020.
//

import UIKit

protocol RefreshSettingsViewController: AnyObject {
    func refreshCurrentGroupName(group: String)
}

class GreetingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        return tableView
    }()
    private let cellId = "cellId"
    let defaults = UserDefaults.standard
    var firstViewController = false
    weak var refreshDocumentsDelegate: RefreshSettingsViewController?

    
    var groups = ["КМБО-02-19,  1пг", "КМБО-02-19,  2пг", "КМБО-05-19,  1пг", "КМБО-05-19,  2пг", "КМБО-02-18,  1пг", "КМБО-02-18,  2пг", "КМБО-05-18,  1пг", "КМБО-05-18,  2пг", "КМБО-02-17,  1пг", "КМБО-02-17,  2пг", "КМБО-05-17,  1пг", "КМБО-05-17,  2пг", "КМБО-02-16", "КММО-02-19", "КММО-02-18"]
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        tableView.reloadData()


    }
    
    func setupTableView() {
        view.addSubview(tableView)
        

        tableView.delegate = self
        tableView.dataSource = self
//        self.tableView.rowHeight = 80
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                                        
        ])
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "1 курс"
        } else if section == 1 {
            return "2 курс"
        } else if section == 2 {
            return "3 курс"
        } else if section == 3 {
            return "4 курс"
        } else if section == 4 {
            return "Магистры, 1 курс"
        } else {
            return "Магистры, 2 курс"
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        } else if section == 1 {
            return 4
        } else if section == 2 {
            return 4
        } else if section == 3 {
            return 1
        } else if section == 4 {
            return 1
        } else { // 2 курс маги
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.accessoryType = .disclosureIndicator
//        cell.textLabel!.text = "test"
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.textLabel!.text = groups[0]
            } else if indexPath.row == 1{
                cell.textLabel!.text = groups[1]
            } else if indexPath.row == 2{
                cell.textLabel!.text = groups[2]
            }  else if indexPath.row == 3{
                cell.textLabel!.text = groups[3]
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell.textLabel!.text = groups[4]
            } else if indexPath.row == 1{
                cell.textLabel!.text = groups[5]
            } else if indexPath.row == 2{
                cell.textLabel!.text = groups[6]
            }  else if indexPath.row == 3{
                cell.textLabel!.text = groups[7]
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                cell.textLabel!.text = groups[8]
            } else if indexPath.row == 1{
                cell.textLabel!.text = groups[9]
            } else if indexPath.row == 2{
                cell.textLabel!.text = groups[10]
            }  else if indexPath.row == 3{
                cell.textLabel!.text = groups[11]
            }
        } else if indexPath.section == 3 {
            cell.textLabel!.text = groups[12]
        } else if indexPath.section == 4 {
            cell.textLabel!.text = groups[13]
        } else if indexPath.section == 5 {
            cell.textLabel!.text = groups[14]
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedGroup = [String]()
        if defaults.object(forKey: "selectedGroup") as? [String] == nil {
            firstViewController = true
        }
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                selectedGroup.append("0")
                selectedGroup.append(groups[0])
            } else if indexPath.row == 1{
                selectedGroup.append("0")
                selectedGroup.append(groups[1])
            } else if indexPath.row == 2{
                selectedGroup.append("1")
                selectedGroup.append(groups[2])
            }  else if indexPath.row == 3{
                selectedGroup.append("1")
                selectedGroup.append(groups[3])
            }
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                selectedGroup.append("2")
                selectedGroup.append(groups[4])
            } else if indexPath.row == 1{
                selectedGroup.append("2")
                selectedGroup.append(groups[5])
            } else if indexPath.row == 2{
                selectedGroup.append("3")
                selectedGroup.append(groups[6])
            }  else if indexPath.row == 3{
                selectedGroup.append("3")
                selectedGroup.append(groups[7])
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                selectedGroup.append("4")
                selectedGroup.append(groups[8])
            } else if indexPath.row == 1{
                selectedGroup.append("4")
                selectedGroup.append(groups[9])
            } else if indexPath.row == 2{
                selectedGroup.append("5")
                selectedGroup.append(groups[10])
            }  else if indexPath.row == 3{
                selectedGroup.append("5")
                selectedGroup.append(groups[11])
            }
        } else if indexPath.section == 3 {
            selectedGroup.append("6")
            selectedGroup.append(groups[12])
        } else if indexPath.section == 4 {
            selectedGroup.append("7")
            selectedGroup.append(groups[13])
        } else if indexPath.section == 5 {
            selectedGroup.append("8")
            selectedGroup.append(groups[14])
        }
        
        let defaults = UserDefaults.standard
        defaults.set(selectedGroup, forKey: "selectedGroup")
        
        if firstViewController {
            let controller = MainTabBarController()
            let navController = UINavigationController(rootViewController: controller)
            navController.setNavigationBarHidden(true, animated: false)
            navController.modalPresentationStyle = .fullScreen
            present(navController, animated: true, completion: nil)
            
            
        } else {
            refreshDocumentsDelegate?.refreshCurrentGroupName(group: selectedGroup[1])
            dismiss(animated: true, completion: nil)
        }

        
        
    }
    
    



}
