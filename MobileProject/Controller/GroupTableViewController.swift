//
//  GroupTableViewController.swift
//  MobileProject
//
//  Created by Janus on 2017. 12. 6..
//  Copyright © 2017년 Janus. All rights reserved.
//

import UIKit

class GroupTableViewController: UITableViewController {
    @IBOutlet var grouptableView: UITableView!
    var searchController: UISearchController!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        grouptableView.delegate = self
        grouptableView.dataSource = self
        
        //grouptableView.contentInsetAdjustmentBehavior = .never
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
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
        //데이터베이스에서 그룹갯수 가져옴
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTableViewButtonCell", for: indexPath) as! GroupTableViewButtonCell
            cell.addGroup.setTitle("Add Group", for: .normal)
            
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTableViewTextCell", for: indexPath) as! GroupTableViewTextCell
            //타이틀이랑 관리자 가져오기
            cell.groupNameLabel.text = "Name"
            cell.groupManagerLabel.text = "Manager"
            
            return cell
            
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
