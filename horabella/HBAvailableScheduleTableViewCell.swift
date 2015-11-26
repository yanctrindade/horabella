//
//  HBAvailableScheduleTableViewCell.swift
//  horabella
//
//  Created by Erick Leal on 18/11/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit

class HBAvailableScheduleTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let view = UIView()
        view.backgroundColor = UIColor(red:0.92, green:0.63, blue:0.66, alpha:1.0)
        selectedBackgroundView = view
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            timeLabel.textColor = UIColor.whiteColor()
        }else{
            timeLabel.textColor = UIColor.blackColor()
        }

        // Configure the view for the selected state
    }

}
