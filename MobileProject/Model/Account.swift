//
//  Account.swift
//  MobileProject
//
//  Created by Janus on 2017. 12. 10..
//  Copyright © 2017년 Janus. All rights reserved.
//

import Foundation

class Account {
    var id: String?
    var pw: String?
    
    init(id: String?, pw: String?) {
        self.id = id
        self.pw = pw
    }
    
    convenience init() {
        self.init(id: "", pw: "")
    }
}
