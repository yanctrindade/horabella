//
//  HBProfessinalTableViewCell.swift
//  horabella
//
//  Created by Erick Leal on 18/11/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit

class HBProfessinalTableViewCell: UITableViewCell {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photo.layer.cornerRadius = photo.frame.size.width/2
        photo.clipsToBounds = true
        
        photo.image = UIImage(named: "profileNoPicture")
        
        let view = UIView()
        view.backgroundColor = UIColor(red:0.92, green:0.63, blue:0.66, alpha:1.0)
        selectedBackgroundView = view
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            name.textColor = UIColor.whiteColor()
        }else{
            name.textColor = UIColor.blackColor()
        }
        // Configure the view for the selected state
    }

}
