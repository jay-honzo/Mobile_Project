//
//  DetailGroupViewController.swift
//  MobileProject
//
//  Created by Janus on 2017. 12. 15..
//  Copyright © 2017년 Janus. All rights reserved.
//

import UIKit
import Firebase

class DetailGroupViewController: UIViewController, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource {
    var refdata : DatabaseReference!
    var account = Account();
    var group = MyGroup();
    var key :DatabaseQuery!
    var dataList = [Mydata]()
    var count = 0
    var userid = ""
    @IBOutlet var titleField: HoshiTextField!{
        didSet{
            titleField.placeholderFontScale = 1.2
            titleField.clearButtonMode = .whileEditing
        }
    }
    @IBOutlet var memoField: UITextView!
    @IBOutlet var saveButton: UIButton! {
        didSet{
            saveButton.setTitle("Save", for: .normal)
        }
    }
    @IBOutlet var memoTable: UITableView! {
        didSet{
            memoTable.separatorStyle = .none
        }
    }
    @IBOutlet var modifyButton: UIButton! {
        didSet{
            modifyButton.setTitle("Modify Group", for: .normal)
            modifyButton.isHidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = group.name
        navigationController?.hidesBarsOnSwipe = false
        
        memoTable.delegate = self
        memoTable.dataSource = self
        memoField.delegate = self
        
        key = Database.database().reference().child("group").queryOrdered(byChild: "name").queryEqual(toValue: group.name)
        key.observeSingleEvent(of: .value, with: { (snapshot) in
            for snap in snapshot.children {
                let userSnap = snap as! DataSnapshot
                self.userid = userSnap.key
                self.refdata = Database.database().reference().child("group").child(self.userid).child("post")
                self.retrieveData()
            }
        })
        
        if account.id == group.manager {
            modifyButton.isHidden = false
        }
    }
    
    func retrieveData(){
        refdata.observe(DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount > 0 {
                self.dataList.removeAll()
                
                for data in snapshot.children.allObjects as! [DataSnapshot]{
                    let dataObj = data.value as? [String: AnyObject]
                    let name = dataObj!["title"]
                    let date = dataObj!["date"]
                    let detail = dataObj!["detail"]
                    let by = dataObj!["by"]
                    let newdata = Mydata(name : name! as? String, date : date! as? String, detail :  detail! as? String, by: by! as? String)
                    self.dataList.append(newdata)
                }
                
                self.memoTable.reloadData()
            }
        })
    }
    
    @IBAction func btnAddData(sender: Any){
        addData()
        
        titleField.text = ""
        memoField.text = ""
        saveButton.resignFirstResponder()
        
        retrieveData()
        memoTable.reloadData()
    }
    
    func addData(){
        let todaysDate = Date()
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        let date = dateformatter.string(from: todaysDate)
        let key = refdata.childByAutoId().key
        let newdata = ["title": titleField.text! as String,
                       "by": account.id! as String,
                       "detail": memoField.text! as String,
                       "date": date as String]
        refdata.child(key).setValue(newdata)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if count == 0 {
            memoField.text = ""
            count+=1
        } else {
            
        }
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "DetailGroupTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DetailGroupTableViewCell
        cell.accessoryType = .disclosureIndicator
        
        let data: Mydata
        data = dataList[indexPath.row]
        cell.byLabel.text = "Writer : " + data.by!
        cell.nameLabel.text = data.name

        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = dataList[indexPath.row]
        let showDetail = UIAlertController(title: data.detail, message: "date :  " + data.date!, preferredStyle: .alert)
        showDetail.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(showDetail, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "modifyGroup" {
            let destinationController = segue.destination as! GroupModifyViewController
            destinationController.account = account
            destinationController.group = group
        }
     }
    
    
}
