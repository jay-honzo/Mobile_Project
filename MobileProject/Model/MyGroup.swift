//
//  MyGroup.swift
//  MobileProject
//
//  Created by Janus on 2017. 12. 10..
//  Copyright © 2017년 Janus. All rights reserved.
//

import Foundation

class MyGroup {
    var name: String?
    var manager: String?
    var member: String?
    var description: String?
    
    init(name: String?, manager: String?, member: String?, description: String?) {
        self.name = name
        self.manager = manager
        self.description = description
    }
    
    convenience init() {
        self.init(name: "", manager: "", member:"", description: "")
    }
}
