//
//  ChatSettingsTableViewController.swift
//  Dialog
//
//  Created by Kirill Dobryakov on 29.07.2018.
//  Copyright © 2017 Kirill Dobryakov. All rights reserved.
//

import UIKit

class ChatSettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupNavigationController()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    func setupNavigationController(){


        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 480, height: 44))
        label.numberOfLines = 2
        label.text =  "Настройки чата"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "SFUIText-Regular", size: 15)
        
        navigationItem.titleView = label
    }
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let button = UIBarButtonItem()
        button.title = ""
        button.style = .plain
        navigationItem.backBarButtonItem = button
        
        self.navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage()
    }

}
