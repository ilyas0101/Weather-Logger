//
//  InfoCell.swift
//  Weather Logger
//
//  Created by ilyas Yavuz on 25.02.2020.
//  Copyright © 2020 ilyas Yavuz. All rights reserved.
//

import UIKit

class InfoCell: UICollectionViewCell {
    static let identifier = "InfoCell"
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var infoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func willDisplay(info: String, name: String?, image: UIImage?) {
        infoLabel.text = info
        infoLabel.adjustsFontSizeToFitWidth = true
        if image != nil {
            nameLabel.isHidden = true
            infoImageView.isHidden = false
            infoImageView.image = image
        } else {
            nameLabel.isHidden = false
            infoImageView.isHidden = true
            nameLabel.adjustsFontSizeToFitWidth = true
            nameLabel.text = name
        }
    }
}
