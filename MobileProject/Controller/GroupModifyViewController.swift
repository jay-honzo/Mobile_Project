//
//  GroupModifyViewController.swift
//  MobileProject
//
//  Created by Janus on 2017. 12. 15..
//  Copyright © 2017년 Janus. All rights reserved.
//

import UIKit
import Firebase

class GroupModifyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {
    @IBOutlet var saveButton: UIButton!
    var refdata : DatabaseReference!
    var postdata: DatabaseReference!
    var account = Account();
    var group = MyGroup();
    var key :DatabaseQuery!
    var dataList = [Mydata]()
    var newGroup = MyGroup()
    var memberList = [String]()
    var uid = String("")
    var descriptionCell = ModifyDescriptionCell()
    var count = 0
    
    @IBOutlet var modifyTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = group.name
        
        modifyTable.delegate = self
        modifyTable.dataSource = self
        modifyTable.separatorStyle = .none
        
        refdata = Database.database().reference().child("group")
        key = refdata.queryOrdered(byChild: "name").queryEqual(toValue: group.name)
        key.observeSingleEvent(of: .value, with: { (snapshot) in
            for snap in snapshot.children {
                let userSnap = snap as! DataSnapshot
                self.uid = userSnap.key //the uid of each user
                self.postdata = Database.database().reference().child("group").child(self.uid).child("post")
            }
        })
        
        memberList = (group.member?.components(separatedBy: "\n"))!
    }
    
    override func viewDidAppear(_ animated: Bool) {
        modifyTable.reloadData()
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ModifyNameCell", for: indexPath) as! ModifyNameCell
            cell.nameLabel.text = group.name
            newGroup.name = cell.nameLabel.text
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ModifyDescriptionCell", for: indexPath) as! ModifyDescriptionCell
            cell.descriptionView.text = group.description
            cell.descriptionView.delegate = self
            if newGroup.description != ""{
                cell.descriptionView.text = newGroup.description
            }
            
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ModifyButtonCell", for: indexPath) as! ModifyButtonCell
            
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ModifyMemberCell", for: indexPath) as! ModifyMemberCell
            cell.memberLabel.text = memberList.joined(separator: "\n")
            newGroup.member = cell.memberLabel.text
            
            return cell
        default:
            fatalError()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        newGroup.description = textView.text
    }
    
    func textViewDidChange(_ textView: UITextView) {
        newGroup.description = textView.text
    }
    
    func addData() {
        modifyTable.reloadData()
        let newdata = ["name": newGroup.name,
                       "manager": account.id,
                       "member": newGroup.member,
                       "description": newGroup.description]
        refdata.child(uid).setValue(newdata)
        group.name = newGroup.name
        group.description = newGroup.description
        group.member = newGroup.member
    }
    
    func retrievePost(){
        dataList.removeAll()
        postdata.observeSingleEvent(of: .value, with: { (snapshot) in
            if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapshots{
                    let name = snap.childSnapshot(forPath: "title").value as! String
                    let date = snap.childSnapshot(forPath: "date").value as! String
                    let detail = snap.childSnapshot(forPath: "detail").value as! String
                    let by = snap.childSnapshot(forPath: "by").value as! String
                    let newdata = Mydata(name : name, date : date, detail :  detail, by: by)
                    self.dataList.append(newdata)
                }
            }
            self.addData()
            self.addPost(datas: self.dataList)
            print(self.dataList.count)
        })
    }
    
    func addPost(datas: [Mydata]) {
        for data in datas {
            let key = self.postdata.childByAutoId().key
            let newdata = ["title": data.name,
                           "by": data.by,
                           "detail": data.detail,
                           "date": data.date]
            self.postdata.child(key).setValue(newdata)
        }
    }
    
    @IBAction func saveButtontouched() {
        //addData()
        retrievePost()
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchMemberSegue2" {
            let destinationController = segue.destination as! SearchMemberController
            destinationController.viewList = memberList
        }
    }
}
