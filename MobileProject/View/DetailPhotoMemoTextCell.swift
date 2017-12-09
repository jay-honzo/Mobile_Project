//
//  DetailPhotoMemoTextCell.swift
//  MobileProject
//
//  Created by Janus on 2017. 12. 7..
//  Copyright © 2017년 Janus. All rights reserved.
//

import UIKit

class DetailPhotoMemoTextCell: UITableViewCell {
    
    @IBOutlet var textLable: UILabel!{
        didSet{
            textLable.numberOfLines = 0
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
