//
//  SearchTableViewCell.swift
//  Interview Task
//
//  Created by Apple on 11/26/18.
//  Copyright © 2018 Dtech. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_email: UILabel!
    @IBOutlet weak var img_avatar: UIImageView!
    @IBOutlet weak var lbl_name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
