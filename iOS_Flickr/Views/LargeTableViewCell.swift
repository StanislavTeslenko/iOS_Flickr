//
//  LargeTableViewCell.swift
//  iOS_Flickr
//
//  Created by Stanislav Teslenko on 14.12.2019.
//  Copyright © 2019 Stanislav Teslenko. All rights reserved.
//

import UIKit

class LargeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var megapixelsLabel: UILabel!
    @IBOutlet weak var screensizeLabel: UILabel!
    @IBOutlet weak var memorytypeLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
