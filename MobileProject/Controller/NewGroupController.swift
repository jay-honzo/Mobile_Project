//
//  NewGroupController.swift
//  MobileProject
//
//  Created by Janus on 2017. 12. 11..
//  Copyright © 2017년 Janus. All rights reserved.
//

import UIKit
import Firebase

class NewGroupController: UITableViewController, UITextViewDelegate {
    var dataList = [MyGroup]()
    var refdata : DatabaseReference!
    var account = Account();
    var count = 0
    var exgroupTableView: UITableView!
    
    @IBOutlet var newGroupTableView: UITableView!
    @IBOutlet var nameField: HoshiTextField!{
        didSet{
            nameField.placeholderFontScale = 1.2
            nameField.clearButtonMode = .whileEditing
        }
    }
    @IBOutlet var infoField: UITextView!
    @IBOutlet var idField: UILabel!{
        didSet{
            idField.numberOfLines = 0
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        refdata = Database.database().reference().child("group")
        
        infoField.delegate = self
        newGroupTableView.separatorStyle = .none
    }

    //MARK:- 텍스트뷰 초기화
    func textViewDidBeginEditing(_ textView: UITextView) {
        if count == 0 {
            infoField.text = ""
            count+=1
        } else {
            
        }
    }
    
    func addData(){
        let key = refdata.childByAutoId().key
        let newdata = ["name":nameField.text! as String,
                       "manager": account.id! as String,
                       "member": idField.text! as String,
                       "description": infoField.text! as String]
        refdata.child(key).setValue(newdata)
        print("New Data Added")
    
        exgroupTableView.reloadData()
    }
    
    @IBAction func saveGroup(){
        dismiss(animated: true, completion: addData)
    }
    
    @IBAction func goBack(){
        dismiss(animated: true, completion: nil)
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
        return 5
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
