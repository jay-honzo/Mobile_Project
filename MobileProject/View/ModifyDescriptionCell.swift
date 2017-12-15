//
//  ModifyDescriptionCell.swift
//  MobileProject
//
//  Created by Janus on 2017. 12. 15..
//  Copyright © 2017년 Janus. All rights reserved.
//

import UIKit

class ModifyDescriptionCell: UITableViewCell {
    @IBOutlet var descriptionView: UITextView!{
        didSet{
            descriptionView.text = " asdf"
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
