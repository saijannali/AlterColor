//
//  TableViewController.swift
//  AlterColor
//
//  Created by Sai Jannali on 4/19/21.
//

// Assignment 02 4/27/2021
//
// Alter Color
//
// Serena Press - sapress@iu.edu
// Sai Jannali - sjannali@iu.edu
// Aidan Lesh - ailesh@iu.edu

import UIKit

class ViewAllTableViewController: UITableViewController {
    
    var appDelegate: AppDelegate!
    var theDataModel:ColorDataModel!
    var theSavedData:SavedData!
    var controller : ViewAllTableViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.theDataModel = self.appDelegate.allData
        self.theSavedData = self.appDelegate.savedData
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(theSavedData.images.count)
        return theSavedData.images.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell", for: indexPath) as! ViewAllTableViewCell

        let row = indexPath.row
        // Configure the cell...
        cell.backgroundColor = UIColor.green
        cell.thumbnail.image = theSavedData.images[row].image
        cell.filenameLabel.text = theSavedData.images[row].filename
        cell.dateModifiedLabel.text = theSavedData.images[row].dateModified
        self.tableView.rowHeight = 167.0

        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        (view as! UITableView).reloadData()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
