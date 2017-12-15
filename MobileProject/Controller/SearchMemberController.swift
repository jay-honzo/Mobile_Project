//
//  SearchMemberController.swift
//  MobileProject
//
//  Created by Janus on 2017. 12. 12..
//  Copyright © 2017년 Janus. All rights reserved.
//

import UIKit
import Firebase

class SearchMemberController: UITableViewController, UISearchResultsUpdating, UINavigationControllerDelegate {
    var searchController: UISearchController!
    @IBOutlet var searchMemberTable: UITableView!
    var searchResults: [String] = []
    var viewList: [String] = []
    var refdata : DatabaseReference!
    var account = Account();
    var key : DatabaseQuery!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Search Member"
        navigationController?.delegate = self
        
        searchController = UISearchController(searchResultsController: nil)
        searchMemberTable.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false

        refdata = Database.database().reference().child("user")
    }
    
    func filterContent(for searchText: String) {
        key = refdata.queryOrdered(byChild: "id")
        
        key.observeSingleEvent(of: .value, with: { (snapshot) in
                if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                    for snap in snapshots{
                        let id = snap.childSnapshot(forPath: "id").value as! String
                        if id.localizedCaseInsensitiveContains(searchText){
                            self.searchResults.append(id)
                        }
                    }
                    self.searchMemberTable.reloadData()
                }
        })
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            self.searchResults.removeAll()
            filterContent(for: searchText)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive {
            return 1 + searchResults.count
        } else {
            return 1 + viewList.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = searchMemberTable.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchMemberCell
            cell.memberLabel.text = "Search Result"
            
            return cell
        default:
            let cell = searchMemberTable.dequeueReusableCell(withIdentifier: "SearchMemberCell", for: indexPath) as! SearchMemberCell
            if searchController.isActive{
                cell.memberLabel.text = searchResults[indexPath.row-1]
                if viewList.contains(cell.memberLabel.text!) {
                    cell.accessoryType = .checkmark
                } else {
                    cell.accessoryType = .none
                }
            } else {
                cell.memberLabel.text = viewList[indexPath.row-1]
                cell.accessoryType = .none
            }
            
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchController.isActive {
            let cell = searchMemberTable.cellForRow(at: indexPath) as! SearchMemberCell
            if cell.accessoryType == .checkmark{
                cell.accessoryType = .none
                let index = viewList.index(of: cell.memberLabel.text!)
                viewList.remove(at: index!)
            } else{
                cell.accessoryType = .checkmark
                if viewList.contains(cell.memberLabel.text!) != true{
                    viewList.append(cell.memberLabel.text!)
                }
            }
        }
    }
    
    /*
    override func willMove(toParentViewController parent: UIViewController?) {
        if let formerViewController = parent as? NewGroupController {
            formerViewController.memberList = viewList
        } else if let formerViewController = parent as? GroupModifyViewController {
            formerViewController.memberList = viewList
        }
    }*/
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let formViewController = viewController as? GroupModifyViewController {
            formViewController.memberList = viewList
        }
        else if let formerViewController = viewController as? NewGroupController {
            formerViewController.memberList = viewList
        }
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

    
    // MARK: - Navigation
   /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveMember" {
            let navController = segue.destination as! UINavigationController
            let destinationController = navController.topViewController as! NewGroupController
            destinationController.memberList = viewList
        }
    }*/
}
