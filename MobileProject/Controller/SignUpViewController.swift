//
//  SignUpViewController.swift
//  MobileProject
//
//  Created by Janus on 2017. 12. 10..
//  Copyright © 2017년 Janus. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var signUpView: SignUpView!
    var dataList = [MyGroup]()
    var refdata : DatabaseReference!
    var account = Account();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refdata = Database.database().reference().child("user")
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.largeTitleDisplayMode = .never
    
        signUpView.idField.delegate = self
        signUpView.passwordField.delegate = self
        signUpView.retypePwField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = signUpView.viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            signUpView.becomeFirstResponder()
        }
        
        return true
    }
    
    @IBAction func checkid(){
        
        print(signUpView.idField.text)
        let key = refdata.queryOrdered(byChild: "id").queryEqual(toValue: signUpView.idField.text)
        
        key.observeSingleEvent(of: .value, with: { (snapshot) in
            
            if snapshot.exists(){
                let alertController = UIAlertController(title: "Error", message: "You cannot use this ID", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style:
                    UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
            else{
                let alertController = UIAlertController(title: "OK", message: "You can use this ID", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style:
                    UIAlertActionStyle.default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        })
    }
    
    func addData(){
        let key = refdata.childByAutoId().key
        let newdata = ["id": signUpView.idField.text! as String,
                       "pw": signUpView.passwordField.text! as String]
        refdata.child(key).setValue(newdata)
    }
    
    @IBAction func saveandclose(segue : UIStoryboardSegue){
        
        if ((signUpView.passwordField.text == signUpView.retypePwField.text) == true) {
            let key = refdata.queryOrdered(byChild: "id").queryEqual(toValue: signUpView.idField.text)
            
            key.observeSingleEvent(of: .value, with: { (snapshot) in
                
                if snapshot.exists(){
                    let alertController = UIAlertController(title: "Error", message: "You cannot use this ID", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "OK", style:
                        UIAlertActionStyle.default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                }
                else{
                    let alertController = UIAlertController(title: "OK", message: "Now Log in please", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "OK", style:
                        UIAlertActionStyle.default, handler: {(alert: UIAlertAction!) in
                            self.navigationController?.popViewController(animated: true)
                            }))
                    self.present(alertController, animated: true, completion: nil)
                    self.addData()
                }
            })
        }
        else{
            let alertController = UIAlertController(title: "Error", message: "Check your passworld again", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style:
                UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
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
