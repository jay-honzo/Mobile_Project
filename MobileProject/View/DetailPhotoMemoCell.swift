//
//  DetailPhotoMemoCell.swift
//  MobileProject
//
//  Created by Janus on 2017. 12. 7..
//  Copyright © 2017년 Janus. All rights reserved.
//

import UIKit

class DetailPhotoMemoCell: UITableViewCell {
    @IBOutlet var memoLable: UILabel!{
        didSet{
            memoLable.numberOfLines = 0
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
