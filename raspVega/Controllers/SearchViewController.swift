//
//  SearchViewController.swift
//  raspVega
//
//  Created by Peter Kvasnikov on 27.11.2020.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    private var timer: Timer?
    private let searchController = UISearchController(searchResultsController: nil)
    private let cellId = "cellId"
    
    var groups = [
        ["КМБО-02-19, 1пг", "0"],
        ["КМБО-02-19, 2пг", "0"],
        ["КМБО-05-19, 1пг", "1"],
        ["КМБО-05-19, 2пг", "1"],
        ["КМБО-02-18, 1пг", "2"],
        ["КМБО-02-18, 2пг", "2"],
        ["КМБО-05-18, 1пг", "3"],
        ["КМБО-05-18, 2пг", "3"],
        ["КМБО-02-17, 1пг", "4"],
        ["КМБО-02-17, 2пг", "4"],
        ["КМБО-05-17, 1пг", "5"],
        ["КМБО-05-17, 2пг", "5"],
        ["КМБО-02-16", "6"],
        ["КММО-02-19", "7"],
        ["КММО-02-18", "8"]
    ]
    var filteredGroups = [[String]]()
    
    var searchResults = [[String]]()
    
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        return tableView
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["по группе", "по преподавателю"])
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        
        searchResults = groups
        
        self.segmentedControl.selectedSegmentIndex = 0
        
        view.addSubview(segmentedControl)

        
        segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        setupTableView()
        


        // Do any additional setup after loading the view.
    }
    
    private func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.showsSearchResultsButton = true;
        searchController.searchBar.showsCancelButton = false
        searchController.searchBar.setValue("Отменить", forKey: "cancelButtonText")
        
    }
    
    
    func setupTableView() {
        view.addSubview(tableView)
        

        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.rowHeight = 80
        tableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.keyboardDismissMode = .onDrag
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: segmentedControl.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: segmentedControl.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
                                        
        ])
        

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = ScheduleViewController(transmittedArray: searchResults[indexPath.row])
        let navigationController = UINavigationController(rootViewController: controller)
        present(navigationController, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel!.text = searchResults[indexPath.row][0]
        return cell
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredGroups = []
        searchResults = []
        if searchText == "" {
            searchResults = groups
            self.tableView.reloadData()
        } else {
            for i in groups {
                if i[0].contains(searchText.uppercased()){
                    filteredGroups.append(i)
                    searchResults = filteredGroups
                    
                }
            }
            self.tableView.reloadData()
        }
        
        
        
    }

    

}
