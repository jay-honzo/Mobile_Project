//
//  GroupTableViewController.swift
//  MobileProject
//
//  Created by Janus on 2017. 12. 6..
//  Copyright © 2017년 Janus. All rights reserved.
//

import UIKit
import Firebase

class GroupTableViewController: UITableViewController {
    @IBOutlet var grouptableView: UITableView!
    var searchController: UISearchController!
    public var dataList = [MyGroup]()
    var refdata : DatabaseReference!
    var account = Account();
    var group = MyGroup();
    var count = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        grouptableView.delegate = self
        grouptableView.dataSource = self
        
        //grouptableView.contentInsetAdjustmentBehavior = .never
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = account.id! + "'s Group"
        
        searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        
        refdata = Database.database().reference().child("group")
        if count == 0{
            retrieveData()
            count += 1
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if count > 1 {
            retrieveData()
        }
        count = 2
        grouptableView.reloadData()
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
        //데이터베이스에서 그룹갯수 가져옴
//        return 1 + dataList.count
        return dataList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupTableViewTextCell", for: indexPath) as! GroupTableViewTextCell
            let data: MyGroup
            //data = dataList[indexPath.row - 1]
            data = dataList[indexPath.row]
            //타이틀이랑 관리자 가져오기
            cell.groupNameLabel.text = data.name
            cell.groupManagerLabel.text = "Manager : " + data.manager!
            
            return cell
            
        }
    }
    
    func retrieveData(){
        self.dataList.removeAll()
        let key = refdata.queryOrdered(byChild: "name")
        
        key.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshots{
                    let member = snap.childSnapshot(forPath: "member").value as! String
                    let members: [String] = member.components(separatedBy: "\n")
                    if members.contains(self.account.id!) {
                        let name = snap.childSnapshot(forPath: "name").value as! String
                        let manager = snap.childSnapshot(forPath: "manager").value as! String
                        let description = snap.childSnapshot(forPath: "description").value as! String
                        let member = snap.childSnapshot(forPath: "member").value as! String
                        let newdata = MyGroup(name : name, manager : manager, member : member, description :  description)
                        self.dataList.append(newdata)
                    }
                }
                self.grouptableView.reloadData()
            }
        })
    }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newGroupSegue" {
            let navController = segue.destination as! UINavigationController
            let destinationController = navController.topViewController as! NewGroupController
            destinationController.account = account
            destinationController.dataList = dataList
        }
        if segue.identifier == "showDetailGroup" {
            if let indexPath = grouptableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! DetailGroupViewController
                //destinationController.group = dataList[indexPath.row-1]
                destinationController.group = dataList[indexPath.row]
                destinationController.account = account
            }
        }
     }
    
}
