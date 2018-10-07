//
//  MessageViewController.swift
//  Dialog
//
//  Created by Kirill Dobryakov on 12.08.18.
//  Copyright © 2017 Kirill Dobryakov. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {
 

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var backBarButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
 
    @IBOutlet var addConversationButton: UIButton!

    @IBOutlet var writeMessage: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
        
        searchBar.delegate = self
        searchBar.backgroundImage = UIImage()
        searchBar.backgroundColor = Colors.searchGrayColor
        searchBar.keyboardAppearance = .dark
        searchBar.placeholder = "Поиск"
        setTitleForSearchBarCancelButton(searchBar: searchBar)
        

        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    

    func setupNavigationController(){
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.isHidden = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "burger"), landscapeImagePhone: #imageLiteral(resourceName: "burger"), style: .plain, target: self, action: #selector(openMenu))
        
        navigationItem.rightBarButtonItems = [  UIBarButtonItem(customView:  writeMessage)];
        navigationItem.title = "Сообщения"
    }
    
    func openMenu(){
        self.evo_drawerController?.toggleDrawerSide(.left, animated: true, completion: nil)
    }
    
    
    //MARK: - Actions
    
    @IBAction func addConversationButton(_ sender: Any) {
        let messageWritePeopleController = UIStoryboard(name:"MessageWrite", bundle: nil).instantiateViewController(withIdentifier: "AddMessageEventController")
        
        self.present(messageWritePeopleController, animated: true, completion: nil)
    }
    
    @IBAction func writeMessageButtonAction(_ sender: UIButton) {
               let messageWritePeopleController = UIStoryboard(name:"MessageWrite", bundle: nil).instantiateViewController(withIdentifier: "MessageWritePeopleController")
        
 
        self.present(messageWritePeopleController, animated: true, completion: nil)
    }
    
  
    @IBAction func dismissSelf(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        if searchBar.selectedScopeButtonIndex == 0 {
            navigationItem.rightBarButtonItems = [ UIBarButtonItem(customView:  writeMessage)];
        } else {
            navigationItem.rightBarButtonItems = [ UIBarButtonItem(customView:  addConversationButton)];
        }
        
        
        tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let button = UIBarButtonItem()
        button.title = ""
        button.style = .plain
        navigationItem.backBarButtonItem = button
        
        self.navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
    }

}



extension MessageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if searchBar.selectedScopeButtonIndex == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessagePeopleCell", for: indexPath) as! MessagePeopleCell
            cell.bgViewRightImage = #imageLiteral(resourceName: "historyDeleteButton")
            cell.bgViewRightColor = Colors.historyDelete
            cell.revealDirection = .right
            cell.type = .slidingDoor
            
            cell.delegate = self
            
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MessageEventCell", for: indexPath) as! MessageEventCell
            
            cell.bgViewRightImage = #imageLiteral(resourceName: "historyDeleteButton")
            cell.bgViewRightColor = Colors.historyDelete
            cell.revealDirection = .right
            cell.type = .slidingDoor
            
            cell.delegate = self
            
            return cell
        }
        
    }
}

extension MessageViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let button = UIBarButtonItem()
        button.title = ""
        button.style = .plain
        navigationItem.backBarButtonItem = button
        
        self.navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
        let chatViewController = UIStoryboard(name: "OpenChat", bundle: nil).instantiateViewController(withIdentifier: "OpenChatViewController") as! OpenChatViewController
        self.navigationController?.pushViewController(chatViewController, animated: true)
    }
}

extension MessageViewController : BWSwipeRevealCellDelegate {
    func swipeCellActivatedAction(_ cell: BWSwipeCell, isActionLeft: Bool) {
        // create the alert
        let alert = UIAlertController(title: "Удалить чат?", message: "Здесь нужен будет текст в две строки", preferredStyle: UIAlertControllerStyle.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Да", style: UIAlertActionStyle.destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "Нет", style: UIAlertActionStyle.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
        
    }
}

extension MessageViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        navigationController?.setNavigationBarHidden(true, animated: true)
        return true
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        navigationController?.setNavigationBarHidden(false, animated: true)
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
}


