//
//  LoginViewController.swift
//  MobileProject
//
//  Created by Janus on 2017. 11. 24..
//  Copyright © 2017년 Janus. All rights reserved.
//

import UIKit
import Firebase

@IBDesignable class LoginViewController: UIViewController, UITextFieldDelegate {
    var dataList = [MyGroup]()
    var refdata : DatabaseReference!
    var account = Account();
    var key : DatabaseQuery!
    
    @IBOutlet var LoginView: LoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirebaseApp.configure()
        refdata = Database.database().reference().child("user")
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Log In"
        
        LoginView.idField.delegate = self
        LoginView.passwordField.delegate = self
    }
    
    @IBAction func checkLogin(){
        let key = refdata.queryOrdered(byChild: "id").queryEqual(toValue: self.LoginView.idField.text)
        
        key.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists() {
                if let snapshots = snapshot.children.allObjects as? [DataSnapshot] {
                    let id = snapshots[0].childSnapshot(forPath: "id").value as! String
                    let password = snapshots[0].childSnapshot(forPath: "pw").value! as! String
                    
                    if self.LoginView.passwordField.text == password {
                        self.account.id = id
                        self.account.pw = password
                        self.performSegue(withIdentifier: "logInSegue", sender: self)
                    } else {
                        let alertController = UIAlertController(title: "Error", message: "Check your Password", preferredStyle: UIAlertControllerStyle.alert)
                        alertController.addAction(UIAlertAction(title: "OK", style:
                            UIAlertActionStyle.default, handler: nil))
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            } else {
                let alertController = UIAlertController(title: "Error", message: "Check your ID", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style:
                    UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        LoginView.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = LoginView.viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            LoginView.becomeFirstResponder()
        }
        
        return true
    }
    
    func endEdit(){
        LoginView.resignFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logInSegue" {
            let tabController = segue.destination as! UITabBarController
            let navController1 = tabController.viewControllers![0] as! UINavigationController
            let photoController = navController1.topViewController as! PhotoTableViewController
            let navController2 = tabController.viewControllers![1] as! UINavigationController
            let groupController = navController2.topViewController as! GroupTableViewController
            groupController.account = account
            photoController.account = account
        }
     }
    
}
