//
//  AddMessageEventController.swift
//  Dialog
//
//  Created by Kirill Dobryakov on 10.08.18.
//  Copyright © 2017 Kirill Dobryakov. All rights reserved.
//

import UIKit

class AddMessageEventController: UIViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet weak var topInsetConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationController()
        setupSearch()
    }

    func filterContentForSearchText(_ searchText: String) {
    }
    
    func setupSearch(){
        // Setup the Search Controller
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = Colors.violet
        searchController.searchBar.barTintColor = UIColor.groupTableViewBackground
        searchController.searchBar.placeholder = "Поиск"
        
        setTitleForSearchBarCancelButton(searchBar: searchController.searchBar)
        
        tableView.tableHeaderView = searchController.searchBar
    }
    
    //MARK: - Action
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Private
    
    func setupNavigationController(){
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.isHidden = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelButton)
        navigationItem.title = "Написать сообщение"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let button = UIBarButtonItem()
        button.title = ""
        button.style = .plain
        navigationItem.backBarButtonItem = button
        
        self.navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
    }
    
}

extension AddMessageEventController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageAddEventCell", for: indexPath) as! MessageAddEventCell
        
        return cell
    }
}

extension AddMessageEventController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!)
    }
}

extension AddMessageEventController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}


