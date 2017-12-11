//
//  SignUpView.swift
//  MobileProject
//
//  Created by Janus on 2017. 12. 10..
//  Copyright © 2017년 Janus. All rights reserved.
//

import UIKit

class SignUpView: UIView {
    @IBOutlet public var idField: HoshiTextField!{
        didSet{
            idField.placeholderFontScale = 1.2
            idField.clearButtonMode = .whileEditing
            idField.tag=1
        }
    }
    
    @IBOutlet public var passwordField: HoshiTextField!{
        didSet{
            passwordField.placeholderFontScale = 1.2
            passwordField.tag = 2
            passwordField.clearsOnBeginEditing = true
        }
    }
    
    @IBOutlet public var retypePwField: HoshiTextField!{
        didSet{
            retypePwField.placeholderFontScale = 1.2
            retypePwField.tag = 3
            retypePwField.clearsOnBeginEditing = true
        }
    }
    
    @IBOutlet var checkIdButton: UIButton!
    @IBOutlet var signupButton: UIButton!

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
