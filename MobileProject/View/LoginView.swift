//
//  LoginView.swift
//  MobileProject
//
//  Created by Janus on 2017. 11. 27..
//  Copyright © 2017년 Janus. All rights reserved.
//

import UIKit

@IBDesignable class LoginView: UIView {
    @IBOutlet var idField: HoshiTextField!{
        didSet{
            idField.clearButtonMode = .whileEditing
            idField.placeholderFontScale = 1.2
            idField.tag = 1
        }
    }
    @IBOutlet var passwordField: HoshiTextField!{
        didSet{
            passwordField.clearsOnBeginEditing = true
            passwordField.placeholderFontScale = 1.2
            passwordField.isSecureTextEntry = true
            passwordField.tag = 2
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
