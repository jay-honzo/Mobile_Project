//
//  MyData.swift
//  MobileProject
//
//  Created by Janus on 2017. 12. 15..
//  Copyright © 2017년 Janus. All rights reserved.
//

import Foundation

class Mydata {
    var name: String?
    var date: String?
    var detail: String?
    var by : String?
    
    
    init(name: String?, date: String?, detail: String?, by: String?) {
        self.name = name
        self.date = date
        self.detail = detail
        self.by = by
    }
    
    convenience init() {
        self.init(name: "", date: "", detail: "", by:"")
    }
}



