//
//  ListTableViewCell.swift
//  TodoApplication
//
//  Created by linear on 2020/03/26.
//  Copyright © 2020 linear. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var updateTime: UILabel!
    @IBOutlet var checkBox: CheckBox!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
