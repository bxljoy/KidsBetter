//
//  TaskTableViewCell.swift
//  KidsBetter
//
//  Created by bxl on 2021/12/18.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var completeButton: UIButton!
    @IBOutlet var taskImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
