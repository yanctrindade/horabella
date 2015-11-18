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
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
