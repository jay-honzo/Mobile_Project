//
//  ModifyMemberCell.swift
//  MobileProject
//
//  Created by Janus on 2017. 12. 15..
//  Copyright © 2017년 Janus. All rights reserved.
//

import UIKit

class ModifyMemberCell: UITableViewCell {
    @IBOutlet var memberLabel: UILabel!{
        didSet{
            memberLabel.numberOfLines = 0
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
