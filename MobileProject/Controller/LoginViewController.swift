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
        
        LoginView.idField.delegate = self
        LoginView.passwordField.delegate = self
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
