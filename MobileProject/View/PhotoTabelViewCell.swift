//
//  PhotoTabelViewCell.swift
//  MobileProject
//
//  Created by Janus on 2017. 12. 6..
//  Copyright © 2017년 Janus. All rights reserved.
//

import UIKit

class PhotoTabelViewCell: UITableViewCell {
    @IBOutlet var memoTitleLabel: UILabel!{
        didSet{
            memoTitleLabel.numberOfLines = 0
        }
    }
    @IBOutlet var memoDateLabel: UILabel!{
        didSet{
            memoDateLabel.numberOfLines = 0
        }
    }
    @IBOutlet var thumbnailImageView: UIImageView! {
        didSet {
            thumbnailImageView.layer.cornerRadius = thumbnailImageView.bounds.width / 2
            thumbnailImageView.clipsToBounds = true
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
