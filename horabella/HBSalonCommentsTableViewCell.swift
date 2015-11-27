//
//  HBSalonCommentsTableViewCell.swift
//  horabella
//
//  Created by Erick Leal on 28/10/15.
//  Copyright © 2015 Yi Mobile. All rights reserved.
//

import UIKit

class HBSalonCommentsTableViewCell: UITableViewCell {

    @IBOutlet weak var userPicture: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var commentDate: UILabel!
    @IBOutlet weak var comment: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userPicture.layer.cornerRadius = userPicture.frame.size.width/2
        userPicture.clipsToBounds = true
        
        userPicture.image = UIImage(named: "profileNoPicture")
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
